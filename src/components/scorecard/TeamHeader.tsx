import type { Team } from '@/lib/types';

type Props = {
  team: Team;
  overallScore?: number;
  year: number;
};

function scoreColor(score: number) {
  if (score >= 0.8) return '#4ade80';
  if (score >= 0.65) return '#facc15';
  if (score >= 0.5) return '#f97316';
  return '#f87171';
}

export default function TeamHeader({ team, overallScore, year }: Props) {
  return (
    <div
      className="border-b border-[#2d3048]"
      style={{ background: `linear-gradient(135deg, ${team.primary_color}22 0%, #0f1117 60%)` }}
    >
      <div className="max-w-7xl mx-auto px-6 py-10">
        <div className="flex items-start justify-between gap-6">
          <div>
            <div className="flex items-center gap-3 mb-1">
              <div
                className="w-3 h-3 rounded-full"
                style={{ backgroundColor: team.primary_color }}
              />
              <span className="text-slate-400 text-sm uppercase tracking-widest font-medium">
                {(team as { leagues?: { name: string } }).leagues?.name}
              </span>
            </div>
            <h1 className="text-4xl font-bold text-white tracking-tight">
              {team.city} {team.name}
            </h1>
            <p className="text-slate-400 mt-1 text-sm">
              Franchise Intelligence Report · {year} Season
            </p>
          </div>

          {overallScore !== undefined && (
            <div className="text-right shrink-0">
              <div
                className="text-6xl font-bold leading-none"
                style={{ color: scoreColor(overallScore) }}
              >
                {Math.round(overallScore * 100)}
              </div>
              <div className="text-slate-400 text-xs mt-1 uppercase tracking-wider">Overall Score</div>
            </div>
          )}
        </div>

        <div className="flex gap-3 mt-6">
          <span className="px-3 py-1 rounded-full text-xs font-medium bg-[#1a1d27] border border-[#2d3048] text-slate-300">
            {team.abbreviation}
          </span>
          {team.founded_year && (
            <span className="px-3 py-1 rounded-full text-xs font-medium bg-[#1a1d27] border border-[#2d3048] text-slate-300">
              Est. {team.founded_year}
            </span>
          )}
          <span className="px-3 py-1 rounded-full text-xs font-medium bg-[#1a1d27] border border-[#2d3048] text-slate-300">
            14 Dimensions
          </span>
        </div>
      </div>
    </div>
  );
}
