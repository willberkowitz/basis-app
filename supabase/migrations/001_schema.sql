-- Basis App Schema
-- Sports franchise intelligence platform

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE leagues (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  abbreviation TEXT NOT NULL UNIQUE,
  sport TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE teams (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  city TEXT NOT NULL,
  abbreviation TEXT NOT NULL UNIQUE,
  league_id UUID REFERENCES leagues(id),
  founded_year INTEGER,
  logo_url TEXT,
  primary_color TEXT DEFAULT '#000000',
  secondary_color TEXT DEFAULT '#FFFFFF',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  section_number INTEGER NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  investor_relevance TEXT,
  weight NUMERIC DEFAULT 1.0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE metrics (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  section_id UUID REFERENCES sections(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  category TEXT,
  data_elements TEXT,
  primary_sources TEXT,
  access_method TEXT,
  refresh_frequency TEXT,
  data_tier TEXT,
  confidence_score NUMERIC CHECK (confidence_score >= 0 AND confidence_score <= 1),
  is_composite BOOLEAN DEFAULT FALSE,
  display_order INTEGER DEFAULT 0,
  value_type TEXT DEFAULT 'numeric',
  unit TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE team_metric_values (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  team_id UUID REFERENCES teams(id) ON DELETE CASCADE,
  metric_id UUID REFERENCES metrics(id) ON DELETE CASCADE,
  year INTEGER NOT NULL DEFAULT 2024,
  value_numeric NUMERIC,
  value_text TEXT,
  value_json JSONB,
  notes TEXT,
  source_url TEXT,
  last_updated TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(team_id, metric_id, year)
);

CREATE INDEX idx_metrics_section_id ON metrics(section_id);
CREATE INDEX idx_metrics_is_composite ON metrics(is_composite);
CREATE INDEX idx_team_metric_values_team_id ON team_metric_values(team_id);
CREATE INDEX idx_team_metric_values_metric_id ON team_metric_values(metric_id);
CREATE INDEX idx_team_metric_values_team_year ON team_metric_values(team_id, year);
