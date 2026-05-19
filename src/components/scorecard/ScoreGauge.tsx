type Props = {
  score: number; // 0–1
  size?: number;
};

function scoreColor(score: number) {
  if (score >= 0.8) return '#4ade80';
  if (score >= 0.65) return '#facc15';
  if (score >= 0.5) return '#f97316';
  return '#f87171';
}

function scoreLabel(score: number) {
  if (score >= 0.8) return 'Strong';
  if (score >= 0.65) return 'Moderate';
  if (score >= 0.5) return 'Developing';
  return 'Weak';
}

export default function ScoreGauge({ score, size = 72 }: Props) {
  const r = (size - 8) / 2;
  const circumference = 2 * Math.PI * r;
  const dash = circumference * score;
  const color = scoreColor(score);

  return (
    <div className="flex flex-col items-center gap-1">
      <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
        <circle
          cx={size / 2}
          cy={size / 2}
          r={r}
          fill="none"
          stroke="#2d3048"
          strokeWidth={6}
        />
        <circle
          cx={size / 2}
          cy={size / 2}
          r={r}
          fill="none"
          stroke={color}
          strokeWidth={6}
          strokeDasharray={`${dash} ${circumference - dash}`}
          strokeLinecap="round"
          transform={`rotate(-90 ${size / 2} ${size / 2})`}
        />
        <text
          x={size / 2}
          y={size / 2 + 1}
          textAnchor="middle"
          dominantBaseline="middle"
          fill={color}
          fontSize={size * 0.22}
          fontWeight="700"
        >
          {Math.round(score * 100)}
        </text>
      </svg>
      <span className="text-[10px] font-medium" style={{ color }}>{scoreLabel(score)}</span>
    </div>
  );
}
