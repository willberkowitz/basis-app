export const dynamic = 'force-dynamic';

import { getTeam, getSectionsWithMetrics } from '@/lib/supabase';
import TeamHeader from '@/components/scorecard/TeamHeader';
import SectionCard from '@/components/scorecard/SectionCard';

const YEAR = 2024;
const TEAM = 'OKC';

export default async function ScorecardPage() {
  const [team, sections] = await Promise.all([
    getTeam(TEAM),
    (async () => {
      const t = await getTeam(TEAM);
      if (!t) return [];
      return getSectionsWithMetrics(t.id, YEAR);
    })(),
  ]);

  if (!team) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="text-center">
          <h2 className="text-xl text-white font-semibold mb-2">Team not found</h2>
          <p className="text-slate-400 text-sm">Make sure your database is set up and seeded.</p>
        </div>
      </div>
    );
  }

  const scoredSections = sections.filter(s => s.compositeScore !== undefined);
  const overallScore = scoredSections.length > 0
    ? scoredSections.reduce((sum, s) => sum + (s.compositeScore ?? 0), 0) / scoredSections.length
    : undefined;

  return (
    <div className="min-h-screen">
      <TeamHeader team={team} overallScore={overallScore} year={YEAR} />

      <div className="max-w-7xl mx-auto px-6 py-8">
        {scoredSections.length > 0 && (
          <div className="mb-8 p-4 bg-[#1a1d27] border border-[#2d3048] rounded-xl">
            <div className="flex items-center gap-8">
              <div>
                <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Dimensions Scored</p>
                <p className="text-2xl font-bold text-white">{scoredSections.length}<span className="text-slate-500 text-base font-normal"> / 14</span></p>
              </div>
              <div className="h-8 w-px bg-[#2d3048]" />
              <div>
                <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Total Metrics</p>
                <p className="text-2xl font-bold text-white">
                  {sections.reduce((sum, s) => sum + s.metrics.filter(m => m.value?.value_numeric !== undefined || m.value?.value_text !== undefined).length, 0)}
                  <span className="text-slate-500 text-base font-normal"> populated</span>
                </p>
              </div>
              <div className="h-8 w-px bg-[#2d3048]" />
              <div>
                <p className="text-xs text-slate-400 uppercase tracking-wider mb-1">Data Year</p>
                <p className="text-2xl font-bold text-white">{YEAR}</p>
              </div>
            </div>
          </div>
        )}

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
          {sections.map(section => (
            <SectionCard key={section.id} section={section} />
          ))}
        </div>

        {sections.length === 0 && (
          <div className="text-center py-24">
            <p className="text-slate-400 text-lg mb-2">No sections found</p>
            <p className="text-slate-600 text-sm">Run the database migrations and seed data to get started.</p>
          </div>
        )}
      </div>
    </div>
  );
}
