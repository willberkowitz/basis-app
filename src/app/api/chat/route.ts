import Anthropic from '@anthropic-ai/sdk';
import { supabase } from '@/lib/supabase';
import type { SectionWithMetrics } from '@/lib/types';

const anthropic = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });

function formatDataForContext(sections: SectionWithMetrics[]): string {
  const lines: string[] = [];

  for (const section of sections) {
    const populated = section.metrics.filter(m =>
      m.value?.value_numeric !== undefined || m.value?.value_text !== undefined || m.value?.value_json !== undefined
    );
    if (populated.length === 0) continue;

    lines.push(`\n## Section ${section.section_number}: ${section.name}`);
    if (section.compositeScore !== undefined) {
      lines.push(`Composite Score: ${(section.compositeScore * 100).toFixed(0)}/100`);
    }

    for (const metric of populated) {
      const v = metric.value;
      let valueStr = '';
      if (v?.value_numeric !== undefined) {
        if (metric.value_type === 'currency') {
          const n = v.value_numeric;
          if (n >= 1e9) valueStr = `$${(n / 1e9).toFixed(2)}B`;
          else if (n >= 1e6) valueStr = `$${(n / 1e6).toFixed(1)}M`;
          else valueStr = `$${n.toLocaleString()}`;
        } else if (metric.value_type === 'percentage') {
          valueStr = `${v.value_numeric.toFixed(1)}%`;
        } else if (metric.value_type === 'score') {
          valueStr = `${(v.value_numeric * 100).toFixed(0)}/100`;
        } else {
          valueStr = v.value_numeric.toLocaleString();
        }
      } else if (v?.value_text) {
        valueStr = v.value_text;
      } else if (v?.value_json) {
        valueStr = JSON.stringify(v.value_json);
      }
      if (v?.notes) valueStr += ` (${v.notes})`;
      lines.push(`- ${metric.name}: ${valueStr}`);
    }
  }

  return lines.join('\n');
}

function buildSystemPrompt(dataContext: string): string {
  return `You are a sports franchise analyst with deep expertise in sports finance, franchise valuation, and investment analysis. You have access to the Oklahoma City Thunder's complete intelligence profile — a 14-dimension framework covering financial performance, market dynamics, league context, fan engagement, brand equity, and more.

Your role is to answer questions about the Thunder's franchise data clearly and insightfully. When you cite numbers, explain what they mean for franchise value and investor decision-making. If a metric is missing, say so rather than guessing.

THUNDER DATA PROFILE (2024):
${dataContext}

FRAMEWORK NOTES:
- Scores are on a 0–100 scale (composite scores)
- Data tiers: Free/Public, Paid/Licensed, Proprietary (self-created)
- Confidence scores reflect source quality and modeling robustness
- 14 sections total; some sections have no data yet as collection is ongoing

Be specific, cite actual numbers, and connect data points to franchise value implications. Keep responses concise but substantive.`;
}

export async function POST(req: Request) {
  const { messages } = await req.json();

  // Fetch Thunder data fresh for each conversation
  const { data: team } = await supabase
    .from('teams')
    .select('id')
    .eq('abbreviation', 'OKC')
    .single();

  let dataContext = 'No data currently available.';

  if (team) {
    const { data: sections } = await supabase.from('sections').select('*').order('section_number');
    const { data: metrics } = await supabase.from('metrics').select('*').order('display_order');
    const { data: values } = await supabase.from('team_metric_values').select('*').eq('team_id', team.id).eq('year', 2024);

    if (sections && metrics && values) {
      const valueMap = new Map(values.map(v => [v.metric_id, v]));
      const sectionsWithMetrics: SectionWithMetrics[] = sections.map(s => {
        const sectionMetrics = metrics.filter(m => m.section_id === s.id).map(m => ({ ...m, value: valueMap.get(m.id) }));
        const composite = sectionMetrics.find(m => m.is_composite);
        return { ...s, metrics: sectionMetrics, compositeScore: composite?.value?.value_numeric };
      });
      dataContext = formatDataForContext(sectionsWithMetrics);
    }
  }

  const systemPrompt = buildSystemPrompt(dataContext);

  const stream = await anthropic.messages.stream({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    system: systemPrompt,
    messages: messages.map((m: { role: string; content: string }) => ({
      role: m.role,
      content: m.content,
    })),
  });

  const readable = new ReadableStream({
    async start(controller) {
      const encoder = new TextEncoder();
      for await (const chunk of stream) {
        if (chunk.type === 'content_block_delta' && chunk.delta.type === 'text_delta') {
          controller.enqueue(encoder.encode(chunk.delta.text));
        }
      }
      controller.close();
    },
  });

  return new Response(readable, {
    headers: { 'Content-Type': 'text/plain; charset=utf-8' },
  });
}
