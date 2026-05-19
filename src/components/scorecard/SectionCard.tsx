import type { SectionWithMetrics } from '@/lib/types';
import ScoreGauge from './ScoreGauge';

type Props = {
  section: SectionWithMetrics;
};

function formatValue(value: number | undefined, valueType: string, unit?: string): string {
  if (value === undefined || value === null) return '—';

  switch (valueType) {
    case 'currency': {
      if (value >= 1_000_000_000) return `$${(value / 1_000_000_000).toFixed(2)}B`;
      if (value >= 1_000_000) return `$${(value / 1_000_000).toFixed(1)}M`;
      if (value >= 1_000) return `$${(value / 1_000).toFixed(0)}K`;
      return `$${value.toFixed(0)}`;
    }
    case 'percentage':
      return `${value.toFixed(1)}%`;
    case 'score':
      return value.toFixed(2);
    case 'ratio':
      return `${value.toFixed(2)}x`;
    default:
      if (unit) return `${value.toLocaleString()} ${unit}`;
      return value.toLocaleString();
  }
}

function TierBadge({ tier }: { tier?: string }) {
  if (!tier) return null;
  const tiers = tier.split('_');
  return (
    <div className="flex gap-1">
      {tiers.map(t => {
        if (t === 'free') return (
          <span key={t} className="px-1.5 py-0.5 rounded text-[10px] font-medium bg-green-950 text-green-400">Free</span>
        );
        if (t === 'paid') return (
          <span key={t} className="px-1.5 py-0.5 rounded text-[10px] font-medium bg-yellow-950 text-yellow-400">Paid</span>
        );
        if (t === 'created') return (
          <span key={t} className="px-1.5 py-0.5 rounded text-[10px] font-medium bg-blue-950 text-blue-400">Proprietary</span>
        );
        return null;
      })}
    </div>
  );
}

export default function SectionCard({ section }: Props) {
  const nonComposite = section.metrics.filter(m => !m.is_composite);
  const keyMetrics = nonComposite.filter(m => m.value?.value_numeric !== undefined || m.value?.value_text !== undefined).slice(0, 4);
  const hasData = section.compositeScore !== undefined;

  return (
    <div className="bg-[#1a1d27] border border-[#2d3048] rounded-xl p-5 flex flex-col gap-4 hover:border-[#3d4060] transition-colors">
      <div className="flex items-start justify-between gap-3">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            <span className="text-[10px] font-bold uppercase tracking-widest text-[#007ac1]">
              Section {section.section_number}
            </span>
          </div>
          <h3 className="text-white font-semibold text-sm leading-snug">{section.name}</h3>
        </div>
        {hasData ? (
          <ScoreGauge score={section.compositeScore!} size={64} />
        ) : (
          <div className="w-16 h-16 rounded-full border-2 border-dashed border-[#2d3048] flex items-center justify-center">
            <span className="text-[10px] text-slate-600 text-center leading-tight">No data</span>
          </div>
        )}
      </div>

      {keyMetrics.length > 0 && (
        <div className="space-y-2.5 border-t border-[#2d3048] pt-3">
          {keyMetrics.map(metric => (
            <div key={metric.id} className="flex items-start justify-between gap-2">
              <div className="flex-1 min-w-0">
                <p className="text-slate-400 text-xs leading-snug truncate">{metric.name}</p>
                {metric.data_tier && (
                  <TierBadge tier={metric.data_tier} />
                )}
              </div>
              <span className="text-white text-xs font-mono font-medium shrink-0">
                {metric.value?.value_text
                  ? metric.value.value_text.slice(0, 30)
                  : formatValue(metric.value?.value_numeric, metric.value_type, metric.unit)}
              </span>
            </div>
          ))}
        </div>
      )}

      {!hasData && keyMetrics.length === 0 && (
        <p className="text-slate-600 text-xs italic">Data collection pending</p>
      )}

      <div className="flex items-center justify-between mt-auto pt-2 border-t border-[#2d3048]">
        <span className="text-slate-600 text-[10px]">
          {section.metrics.filter(m => m.value?.value_numeric !== undefined || m.value?.value_text !== undefined).length} / {section.metrics.length} metrics
        </span>
        {section.compositeScore !== undefined && (
          <span className="text-slate-500 text-[10px]">
            Confidence: {Math.round((section.metrics.find(m => m.is_composite)?.confidence_score ?? 0) * 100)}%
          </span>
        )}
      </div>
    </div>
  );
}
