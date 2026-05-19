import { createClient } from '@supabase/supabase-js';
import type { SectionWithMetrics, Team } from './types';

function getSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const key = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !key) throw new Error('Supabase env vars not set. Copy .env.local.example to .env.local and fill in your credentials.');
  return createClient(url, key);
}

export const supabase = {
  from: (table: string) => getSupabase().from(table),
};

export async function getTeam(abbreviation: string): Promise<Team | null> {
  try {
    const { data, error } = await supabase
      .from('teams')
      .select('*, leagues(*)')
      .eq('abbreviation', abbreviation)
      .single();

    if (error) {
      console.error('Error fetching team:', error);
      return null;
    }
    return data;
  } catch (e) {
    console.error('Supabase not configured:', e);
    return null;
  }
}

export async function getSectionsWithMetrics(teamId: string, year = 2024): Promise<SectionWithMetrics[]> {
  try {
    const { data: sections, error: sectionsError } = await supabase
      .from('sections')
      .select('*')
      .order('section_number');

    if (sectionsError || !sections) return [];

    const { data: metrics, error: metricsError } = await supabase
      .from('metrics')
      .select('*')
      .order('display_order');

    if (metricsError || !metrics) return [];

    const { data: values, error: valuesError } = await supabase
      .from('team_metric_values')
      .select('*')
      .eq('team_id', teamId)
      .eq('year', year);

    if (valuesError) console.error('Error fetching values:', valuesError);

    const valuesByMetricId = new Map((values || []).map(v => [v.metric_id, v]));

    return sections.map(section => {
      const sectionMetrics = metrics
        .filter(m => m.section_id === section.id)
        .map(m => ({ ...m, value: valuesByMetricId.get(m.id) }));

      const composite = sectionMetrics.find(m => m.is_composite);
      const compositeScore = composite?.value?.value_numeric ?? undefined;

      return {
        ...section,
        metrics: sectionMetrics,
        compositeScore,
      };
    });
  } catch (e) {
    console.error('Supabase not configured:', e);
    return [];
  }
}

export async function getAllTeamData(teamId: string, year = 2024) {
  const sections = await getSectionsWithMetrics(teamId, year);
  return sections;
}
