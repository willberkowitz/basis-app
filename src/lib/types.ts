export type League = {
  id: string;
  name: string;
  abbreviation: string;
  sport: string;
};

export type Team = {
  id: string;
  name: string;
  city: string;
  abbreviation: string;
  league_id: string;
  primary_color: string;
  secondary_color: string;
  founded_year?: number;
  logo_url?: string;
  leagues?: League;
};

export type Section = {
  id: string;
  section_number: number;
  name: string;
  description?: string;
  investor_relevance?: string;
  weight: number;
};

export type Metric = {
  id: string;
  section_id: string;
  name: string;
  category?: string;
  data_tier?: string;
  confidence_score?: number;
  is_composite: boolean;
  display_order: number;
  value_type: string;
  unit?: string;
};

export type MetricValue = {
  id: string;
  team_id: string;
  metric_id: string;
  year: number;
  value_numeric?: number;
  value_text?: string;
  value_json?: Record<string, unknown>;
  notes?: string;
};

export type MetricWithValue = Metric & {
  value?: MetricValue;
};

export type SectionWithMetrics = Section & {
  metrics: MetricWithValue[];
  compositeScore?: number;
};

export type ChatMessage = {
  role: 'user' | 'assistant';
  content: string;
};
