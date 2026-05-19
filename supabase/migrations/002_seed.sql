-- Basis Seed Data
-- Oklahoma City Thunder · Full 14-Section Framework

DO $$
DECLARE
  nba_id uuid;
  okc_id uuid;
  -- section IDs
  s1 uuid; s2 uuid; s3 uuid; s4 uuid; s5 uuid; s6 uuid; s7 uuid;
  s8 uuid; s9 uuid; s10 uuid; s11 uuid; s12 uuid; s13 uuid; s14 uuid;
  -- metric IDs used for seeding Thunder data
  m_base_value uuid; m_applied_value uuid; m_revenue uuid; m_ebitda uuid;
  m_ev_multiples uuid; m_rev_mix uuid; m_rev_div uuid; m_fin_vol uuid;
  m_cap_debt uuid; m_league_share uuid; m_fin_composite uuid;
  m_mkt_size uuid; m_median_income uuid; m_corp_density uuid; m_competition_idx uuid;
  m_mkt_growth uuid; m_local_gdp uuid; m_mkt_affluence uuid; m_comp_sat uuid;
  m_mkt_stability uuid; m_mkt_composite uuid;
  m_cba_term uuid; m_media_term uuid; m_league_media_val uuid; m_league_econ uuid;
  m_rev_sharing uuid; m_parity uuid; m_league_growth uuid; m_league_stability uuid;
  m_league_maturity uuid; m_global_reach uuid; m_league_bench uuid; m_league_composite uuid;
  m_avg_attend uuid; m_sellout_rate uuid; m_ticket_rev uuid; m_atp uuid;
  m_premium_occ uuid; m_gameday_yield uuid; m_concessions uuid; m_gameday_merch uuid;
  m_sell_through uuid; m_dyn_pricing uuid; m_attend_consistency uuid; m_gameday_composite uuid;
  m_total_fanbase uuid; m_social_scale uuid; m_dig_engage uuid; m_social_cagr uuid;
  m_fan_retention uuid; m_loyalty_pen uuid; m_fan_sentiment uuid; m_fan_advocacy uuid;
  m_arpf uuid; m_global_fan_dist uuid; m_content_consumption uuid; m_age_div uuid;
  m_fan_tenure uuid; m_fan_depth uuid; m_fan_composite uuid;

BEGIN

-- ============================================================
-- LEAGUE
-- ============================================================
INSERT INTO leagues (name, abbreviation, sport)
VALUES ('National Basketball Association', 'NBA', 'Basketball')
RETURNING id INTO nba_id;

-- ============================================================
-- TEAM
-- ============================================================
INSERT INTO teams (name, city, abbreviation, league_id, founded_year, primary_color, secondary_color)
VALUES ('Thunder', 'Oklahoma City', 'OKC', nba_id, 2008, '#007AC1', '#EF3B24')
RETURNING id INTO okc_id;

-- ============================================================
-- SECTIONS (14)
-- ============================================================
INSERT INTO sections (section_number, name, description, weight) VALUES
(1, 'Financial & Operating Metrics', 'Core revenue, EBITDA, and valuation inputs.', 1.2)
RETURNING id INTO s1;

INSERT INTO sections (section_number, name, description, weight) VALUES
(2, 'Market & Demographics', 'Market size, population, and economic base.', 1.0)
RETURNING id INTO s2;

INSERT INTO sections (section_number, name, description, weight) VALUES
(3, 'League Context', 'League structure, parity, and shared revenue models.', 1.0)
RETURNING id INTO s3;

INSERT INTO sections (section_number, name, description, weight) VALUES
(4, 'Local Media & Sponsorship', 'Regional broadcast and partnership economics.', 0.9)
RETURNING id INTO s4;

INSERT INTO sections (section_number, name, description, weight) VALUES
(5, 'National Media & League Revenue', 'Centralized media and sponsorship distributions.', 1.0)
RETURNING id INTO s5;

INSERT INTO sections (section_number, name, description, weight) VALUES
(6, 'Game Day Economics', 'Ticketing, concessions, and venue revenue performance.', 1.0)
RETURNING id INTO s6;

INSERT INTO sections (section_number, name, description, weight) VALUES
(7, 'Non-Game-Day & Licensed Revenue', 'Merchandising, licensing, and digital IP monetization.', 0.9)
RETURNING id INTO s7;

INSERT INTO sections (section_number, name, description, weight) VALUES
(8, 'Stadium Economics', 'Ownership structure, event utilization, and financial performance.', 0.9)
RETURNING id INTO s8;

INSERT INTO sections (section_number, name, description, weight) VALUES
(9, 'Ancillary Revenue & Holdings', 'Real estate, media networks, and cross-asset value.', 0.8)
RETURNING id INTO s9;

INSERT INTO sections (section_number, name, description, weight) VALUES
(10, 'Fan Engagement & Audience Dynamics', 'Scale, loyalty, and behavioral engagement.', 1.1)
RETURNING id INTO s10;

INSERT INTO sections (section_number, name, description, weight) VALUES
(11, 'Brand Engagement & Market Presence', 'Global awareness, cultural relevance, and sponsorship appeal.', 1.0)
RETURNING id INTO s11;

INSERT INTO sections (section_number, name, description, weight) VALUES
(12, 'Durability, Predictability & Structural Resilience', 'Governance, stability, and downside protection.', 1.1)
RETURNING id INTO s12;

INSERT INTO sections (section_number, name, description, weight) VALUES
(13, 'Growth Potential & Expansion Capacity', 'Market headroom, innovation, and scalability.', 1.0)
RETURNING id INTO s13;

INSERT INTO sections (section_number, name, description, weight) VALUES
(14, 'Valuation Multiples & Investor Sentiment', 'Market perception, transaction data, and valuation alignment.', 1.0)
RETURNING id INTO s14;

-- ============================================================
-- SECTION I METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Base Estimated Franchise Value', 'Valuation & Financial Performance', 'free_created', 0.90, false, 1, 'currency', 'USD')
RETURNING id INTO m_base_value;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Applied Estimated Franchise Value', 'Valuation & Financial Performance', 'created', 0.85, false, 2, 'currency', 'USD')
RETURNING id INTO m_applied_value;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Revenue (Total, YoY, 3yr CAGR)', 'Valuation & Financial Performance', 'free_created', 0.95, false, 3, 'json', NULL)
RETURNING id INTO m_revenue;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Operating Income (EBITDA)', 'Valuation & Financial Performance', 'free_created', 0.90, false, 4, 'currency', 'USD')
RETURNING id INTO m_ebitda;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Valuation Multiples (EV/Revenue, EV/EBITDA)', 'Valuation & Financial Performance', 'created', 0.95, false, 5, 'json', NULL)
RETURNING id INTO m_ev_multiples;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Revenue Mix by Source', 'Valuation & Financial Performance', 'paid_created', 0.80, false, 6, 'json', NULL)
RETURNING id INTO m_rev_mix;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Revenue Diversification Index', 'Valuation & Financial Performance', 'created', 0.80, false, 7, 'score', NULL)
RETURNING id INTO m_rev_div;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Financial Volatility Index', 'Valuation & Financial Performance', 'created', 0.75, false, 8, 'score', NULL)
RETURNING id INTO m_fin_vol;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Capitalization / Debt Structure', 'Valuation & Financial Performance', 'paid_free', 0.70, false, 9, 'text', NULL)
RETURNING id INTO m_cap_debt;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'League Revenue Share Impact', 'Valuation & Financial Performance', 'paid_created', 0.85, false, 10, 'percentage', NULL)
RETURNING id INTO m_league_share;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s1, 'Financial Health Composite Score', 'Composite', 'created', 0.95, true, 11, 'score', NULL)
RETURNING id INTO m_fin_composite;

-- ============================================================
-- SECTION II METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Market Size (DMA Population)', 'Market & Demographics', 'free', 0.95, false, 1, 'numeric', 'people')
RETURNING id INTO m_mkt_size;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Median Household Income', 'Market & Demographics', 'free', 0.90, false, 2, 'currency', 'USD')
RETURNING id INTO m_median_income;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Corporate Density Index', 'Market & Demographics', 'paid_created', 0.85, false, 3, 'score', NULL)
RETURNING id INTO m_corp_density;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Competition Index', 'Market & Demographics', 'free_created', 0.90, false, 4, 'score', NULL)
RETURNING id INTO m_competition_idx;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Media Market Growth Rate (10yr)', 'Market & Demographics', 'free_created', 0.85, false, 5, 'percentage', NULL)
RETURNING id INTO m_mkt_growth;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Local GDP (Per Capita)', 'Market & Demographics', 'free', 0.90, false, 6, 'currency', 'USD')
RETURNING id INTO m_local_gdp;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Market Affluence Index', 'Market & Demographics', 'created', 0.85, false, 7, 'score', NULL)
RETURNING id INTO m_mkt_affluence;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Competition Saturation Score', 'Market & Demographics', 'created', 0.80, false, 8, 'score', NULL)
RETURNING id INTO m_comp_sat;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Market Stability Index', 'Market & Demographics', 'paid_created', 0.80, false, 9, 'score', NULL)
RETURNING id INTO m_mkt_stability;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s2, 'Market & Demographic Composite Score', 'Composite', 'created', 0.95, true, 10, 'score', NULL)
RETURNING id INTO m_mkt_composite;

-- ============================================================
-- SECTION III METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'CBA Term Remaining', 'League Context', 'free_created', 0.90, false, 1, 'numeric', 'years')
RETURNING id INTO m_cba_term;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'National Media Rights Term Remaining', 'League Context', 'free_created', 0.90, false, 2, 'numeric', 'years')
RETURNING id INTO m_media_term;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Media Rights Value (Annualized)', 'League Context', 'paid_created', 0.85, false, 3, 'currency', 'USD')
RETURNING id INTO m_league_media_val;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Economics Index', 'League Context', 'paid_created', 0.85, false, 4, 'score', NULL)
RETURNING id INTO m_league_econ;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'Revenue Sharing Mechanism Index', 'League Context', 'created', 0.80, false, 5, 'score', NULL)
RETURNING id INTO m_rev_sharing;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Parity Score', 'League Context', 'free_created', 0.85, false, 6, 'score', NULL)
RETURNING id INTO m_parity;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Growth Rate (5yr)', 'League Context', 'free_created', 0.90, false, 7, 'percentage', NULL)
RETURNING id INTO m_league_growth;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Stability Index', 'League Context', 'created', 0.80, false, 8, 'score', NULL)
RETURNING id INTO m_league_stability;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Maturity / Saturation Level', 'League Context', 'created', 0.75, false, 9, 'score', NULL)
RETURNING id INTO m_league_maturity;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Global Reach Index', 'League Context', 'free_created', 0.80, false, 10, 'score', NULL)
RETURNING id INTO m_global_reach;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Competitiveness Benchmark', 'League Context', 'created', 0.85, false, 11, 'score', NULL)
RETURNING id INTO m_league_bench;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s3, 'League Context Composite Score', 'Composite', 'created', 0.95, true, 12, 'score', NULL)
RETURNING id INTO m_league_composite;

-- ============================================================
-- SECTION IV METRICS (definitions only, no Thunder data yet)
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s4, 'Local Media Rights Value', 'Local Media & Sponsorship', 'paid_created', 0.80, false, 1, 'currency'),
(s4, 'Local Media Rights Term Remaining', 'Local Media & Sponsorship', 'free_created', 0.90, false, 2, 'numeric'),
(s4, 'Local Media Coverage Index', 'Local Media & Sponsorship', 'paid_created', 0.80, false, 3, 'score'),
(s4, 'Local Broadcast Reach Index', 'Local Media & Sponsorship', 'paid', 0.80, false, 4, 'score'),
(s4, 'Sponsorship Quality Index (SQI)', 'Local Media & Sponsorship', 'paid_created', 0.85, false, 5, 'score'),
(s4, 'Local Partnership Depth', 'Local Media & Sponsorship', 'paid_created', 0.85, false, 6, 'score'),
(s4, 'Sponsor Category Diversity', 'Local Media & Sponsorship', 'paid_created', 0.85, false, 7, 'score'),
(s4, 'Sponsor Retention Rate', 'Local Media & Sponsorship', 'created', 0.75, false, 8, 'score'),
(s4, 'Sponsorship Revenue (Est.)', 'Local Media & Sponsorship', 'free_created', 0.80, false, 9, 'currency'),
(s4, 'Activation Intensity Score', 'Local Media & Sponsorship', 'paid_created', 0.75, false, 10, 'score'),
(s4, 'Media Fragmentation Risk', 'Local Media & Sponsorship', 'free_created', 0.80, false, 11, 'score'),
(s4, 'Local Sponsorship Yield Index', 'Local Media & Sponsorship', 'created', 0.85, false, 12, 'score'),
(s4, 'Brand Partnership Visibility Score', 'Local Media & Sponsorship', 'paid_created', 0.80, false, 13, 'score'),
(s4, 'Local Media & Sponsorship Composite Score', 'Composite', 'created', 0.95, true, 14, 'score');

-- ============================================================
-- SECTION V METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s5, 'National Media Rights Value (Annualized)', 'National Media & League Revenue', 'paid_created', 0.90, false, 1, 'currency'),
(s5, 'Team-Level National Media Distribution (Est.)', 'National Media & League Revenue', 'created', 0.85, false, 2, 'currency'),
(s5, 'League Sponsorship Pool Value', 'National Media & League Revenue', 'paid_created', 0.85, false, 3, 'currency'),
(s5, 'National Revenue Share (% of Total Team Revenue)', 'National Media & League Revenue', 'created', 0.85, false, 4, 'percentage'),
(s5, 'League Central Revenue CAGR (5yr)', 'National Media & League Revenue', 'free_created', 0.90, false, 5, 'percentage'),
(s5, 'Revenue Sharing Impact Index', 'National Media & League Revenue', 'created', 0.80, false, 6, 'score'),
(s5, 'League Digital Rights Monetization Index', 'National Media & League Revenue', 'paid_created', 0.80, false, 7, 'score'),
(s5, 'International Media Rights Value', 'National Media & League Revenue', 'paid_created', 0.85, false, 8, 'currency'),
(s5, 'League Sponsorship Concentration Risk', 'National Media & League Revenue', 'paid_created', 0.80, false, 9, 'score'),
(s5, 'League Distribution Equity Index', 'National Media & League Revenue', 'created', 0.75, false, 10, 'score'),
(s5, 'League-Level Revenue Stability Index', 'National Media & League Revenue', 'free_created', 0.80, false, 11, 'score'),
(s5, 'National Media & League Revenue Composite Score', 'Composite', 'created', 0.95, true, 12, 'score');

-- ============================================================
-- SECTION VI METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Average Attendance (Home Games)', 'Game Day Economics', 'free', 0.95, false, 1, 'numeric', 'fans')
RETURNING id INTO m_avg_attend;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Average Attendance Percentage (Sellout Rate)', 'Game Day Economics', 'free_created', 0.90, false, 2, 'percentage', NULL)
RETURNING id INTO m_sellout_rate;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Ticket Revenue (Total)', 'Game Day Economics', 'free_created', 0.90, false, 3, 'currency', 'USD')
RETURNING id INTO m_ticket_rev;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Average Ticket Price (ATP)', 'Game Day Economics', 'paid_created', 0.90, false, 4, 'currency', 'USD')
RETURNING id INTO m_atp;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Premium Seat Occupancy Rate', 'Game Day Economics', 'paid_created', 0.85, false, 5, 'percentage', NULL)
RETURNING id INTO m_premium_occ;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Game Day Yield Index', 'Game Day Economics', 'created', 0.85, false, 6, 'currency', 'USD/attendee')
RETURNING id INTO m_gameday_yield;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Concessions Revenue', 'Game Day Economics', 'paid_created', 0.80, false, 7, 'currency', 'USD')
RETURNING id INTO m_concessions;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Game Day Merchandise Sales', 'Game Day Economics', 'paid_created', 0.85, false, 8, 'currency', 'USD')
RETURNING id INTO m_gameday_merch;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Ticket Sell-Through Rate', 'Game Day Economics', 'paid_created', 0.90, false, 9, 'percentage', NULL)
RETURNING id INTO m_sell_through;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Dynamic Pricing Adoption Score', 'Game Day Economics', 'paid_created', 0.85, false, 10, 'score', NULL)
RETURNING id INTO m_dyn_pricing;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Attendance Consistency Index', 'Game Day Economics', 'free_created', 0.90, false, 11, 'score', NULL)
RETURNING id INTO m_attend_consistency;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s6, 'Game Day Economics Composite Score', 'Composite', 'created', 0.95, true, 12, 'score', NULL)
RETURNING id INTO m_gameday_composite;

-- ============================================================
-- SECTION VII METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s7, 'Merchandise Revenue (Team-Controlled)', 'Non-Game-Day & Licensed Revenue', 'paid_created', 0.90, false, 1, 'currency'),
(s7, 'League Licensing Distribution Share', 'Non-Game-Day & Licensed Revenue', 'free_created', 0.85, false, 2, 'currency'),
(s7, 'Local Licensing Revenue (Team-Specific IP)', 'Non-Game-Day & Licensed Revenue', 'paid_created', 0.80, false, 3, 'currency'),
(s7, 'E-Commerce Revenue (Direct-to-Consumer)', 'Non-Game-Day & Licensed Revenue', 'paid_created', 0.85, false, 4, 'currency'),
(s7, 'Digital Content Monetization Index', 'Non-Game-Day & Licensed Revenue', 'free_created', 0.80, false, 5, 'score'),
(s7, 'Branded Experiences & Events Revenue', 'Non-Game-Day & Licensed Revenue', 'free_created', 0.80, false, 6, 'currency'),
(s7, 'Collectibles & Memorabilia Revenue', 'Non-Game-Day & Licensed Revenue', 'paid_created', 0.75, false, 7, 'currency'),
(s7, 'Local Sponsorship Activation Tie-Ins', 'Non-Game-Day & Licensed Revenue', 'paid_created', 0.75, false, 8, 'currency'),
(s7, 'Youth Development & Academy Revenue', 'Non-Game-Day & Licensed Revenue', 'free_created', 0.80, false, 9, 'currency'),
(s7, 'NIL / Player Partnership Program Revenue', 'Non-Game-Day & Licensed Revenue', 'free_created', 0.70, false, 10, 'currency'),
(s7, 'Total Licensed Revenue (Sum of All Licensing Streams)', 'Non-Game-Day & Licensed Revenue', 'created', 0.90, false, 11, 'currency'),
(s7, 'Non-Game-Day & Licensed Revenue Composite Score', 'Composite', 'created', 0.95, true, 12, 'score');

-- ============================================================
-- SECTION VIII METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s8, 'Stadium Ownership Structure', 'Stadium Economics', 'free_created', 0.90, false, 1, 'text'),
(s8, 'Naming Rights Value (Annualized)', 'Stadium Economics', 'paid_created', 0.90, false, 2, 'currency'),
(s8, 'Premium Seating Inventory & Yield', 'Stadium Economics', 'paid_created', 0.85, false, 3, 'json'),
(s8, 'Concert & Third-Party Event Revenue', 'Stadium Economics', 'paid_created', 0.80, false, 4, 'currency'),
(s8, 'Venue Utilization Index', 'Stadium Economics', 'free_created', 0.80, false, 5, 'score'),
(s8, 'Facility Revenue Retention Rate', 'Stadium Economics', 'free_created', 0.75, false, 6, 'percentage'),
(s8, 'Stadium Operating Income (EBITDA)', 'Stadium Economics', 'paid_created', 0.75, false, 7, 'currency'),
(s8, 'Public Funding Ratio', 'Stadium Economics', 'free_created', 0.90, false, 8, 'percentage'),
(s8, 'Debt Service Coverage Ratio (DSCR)', 'Stadium Economics', 'paid_created', 0.80, false, 9, 'ratio'),
(s8, 'Stadium Modernization Index', 'Stadium Economics', 'free_created', 0.85, false, 10, 'score'),
(s8, 'Fan Experience Technology Score', 'Stadium Economics', 'free_created', 0.75, false, 11, 'score'),
(s8, 'Maintenance & Capital Reserve Index', 'Stadium Economics', 'free_created', 0.80, false, 12, 'score'),
(s8, 'Stadium Economics Composite Score', 'Composite', 'created', 0.95, true, 13, 'score');

-- ============================================================
-- SECTION IX METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s9, 'Ancillary Asset Ownership Structure', 'Ancillary Revenue & Holdings', 'free_created', 0.90, false, 1, 'text'),
(s9, 'Real Estate Development Index', 'Ancillary Revenue & Holdings', 'paid_created', 0.85, false, 2, 'score'),
(s9, 'Future or Announced Projects Index', 'Ancillary Revenue & Holdings', 'paid_created', 0.80, false, 3, 'score'),
(s9, 'Saturation Score', 'Ancillary Revenue & Holdings', 'paid_created', 0.80, false, 4, 'score'),
(s9, 'Mixed-Use Real Estate Footprint (Sq. Ft.)', 'Ancillary Revenue & Holdings', 'paid_created', 0.85, false, 5, 'numeric'),
(s9, 'Ancillary Real Estate Value (Est.)', 'Ancillary Revenue & Holdings', 'paid_created', 0.80, false, 6, 'currency'),
(s9, 'Ancillary Revenue (Total)', 'Ancillary Revenue & Holdings', 'paid_created', 0.80, false, 7, 'currency'),
(s9, 'Ancillary Revenue CAGR (3yr)', 'Ancillary Revenue & Holdings', 'created', 0.85, false, 8, 'percentage'),
(s9, 'Media & Network Holdings Value', 'Ancillary Revenue & Holdings', 'paid_created', 0.80, false, 9, 'currency'),
(s9, 'Ancillary Business Integration', 'Ancillary Revenue & Holdings', 'free_created', 0.75, false, 10, 'score'),
(s9, 'Cross-Asset Synergy Index', 'Ancillary Revenue & Holdings', 'created', 0.75, false, 11, 'score'),
(s9, 'Diversification Breadth Index', 'Ancillary Revenue & Holdings', 'free_created', 0.80, false, 12, 'score'),
(s9, 'Revenue Diversification Index', 'Ancillary Revenue & Holdings', 'created', 0.85, false, 13, 'score'),
(s9, 'Liquidity & Monetization Potential', 'Ancillary Revenue & Holdings', 'paid_created', 0.75, false, 14, 'score'),
(s9, 'Regulatory / CBA Exposure Risk', 'Ancillary Revenue & Holdings', 'free_created', 0.80, false, 15, 'score'),
(s9, 'Innovation Index', 'Ancillary Revenue & Holdings', 'paid_created', 0.75, false, 16, 'score'),
(s9, 'Ancillary Value Contribution (% of EV)', 'Ancillary Revenue & Holdings', 'created', 0.90, false, 17, 'percentage'),
(s9, 'Ancillary Revenue & Holdings Composite Score', 'Composite', 'created', 0.95, true, 18, 'score');

-- ============================================================
-- SECTION X METRICS
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Total Fan Base (Aggregate)', 'Fan Engagement', 'free_created', 0.90, false, 1, 'numeric', 'followers')
RETURNING id INTO m_total_fanbase;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Social Scale Index', 'Fan Engagement', 'free_created', 0.95, false, 2, 'score', NULL)
RETURNING id INTO m_social_scale;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Digital Engagement Rate', 'Fan Engagement', 'paid_created', 0.90, false, 3, 'percentage', NULL)
RETURNING id INTO m_dig_engage;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Social Growth CAGR (3yr)', 'Fan Engagement', 'free_created', 0.90, false, 4, 'percentage', NULL)
RETURNING id INTO m_social_cagr;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Fan Retention & Attendance Frequency', 'Fan Engagement', 'paid_created', 0.80, false, 5, 'score', NULL)
RETURNING id INTO m_fan_retention;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Membership / Loyalty Program Penetration', 'Fan Engagement', 'paid_created', 0.85, false, 6, 'score', NULL)
RETURNING id INTO m_loyalty_pen;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Fan Sentiment Index', 'Fan Engagement', 'paid_created', 0.80, false, 7, 'score', NULL)
RETURNING id INTO m_fan_sentiment;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Fan Advocacy Index (NPS Proxy)', 'Fan Engagement', 'created', 0.75, false, 8, 'score', NULL)
RETURNING id INTO m_fan_advocacy;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Average Revenue per Fan (ARPF)', 'Fan Engagement', 'created', 0.80, false, 9, 'currency', 'USD')
RETURNING id INTO m_arpf;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Global Fan Distribution (%)', 'Fan Engagement', 'free_created', 0.85, false, 10, 'percentage', NULL)
RETURNING id INTO m_global_fan_dist;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Content Consumption per Fan', 'Fan Engagement', 'paid_created', 0.90, false, 11, 'numeric', 'min/month')
RETURNING id INTO m_content_consumption;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Audience Age Diversification Index', 'Fan Engagement', 'paid_created', 0.80, false, 12, 'score', NULL)
RETURNING id INTO m_age_div;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Fan Loyalty Tenure Index', 'Fan Engagement', 'created', 0.75, false, 13, 'score', NULL)
RETURNING id INTO m_fan_tenure;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Fan Engagement Depth Score', 'Fan Engagement', 'created', 0.90, false, 14, 'score', NULL)
RETURNING id INTO m_fan_depth;

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type, unit)
VALUES (s10, 'Fan Engagement & Audience Dynamics Composite Score', 'Composite', 'created', 0.95, true, 15, 'score', NULL)
RETURNING id INTO m_fan_composite;

-- ============================================================
-- SECTIONS XI–XIV METRICS (definitions only)
-- ============================================================
INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s11, 'Global Brand Equity Index', 'Brand Engagement', 'paid_created', 0.90, false, 1, 'score'),
(s11, 'Sponsorship Demand Intensity', 'Brand Engagement', 'paid_created', 0.85, false, 2, 'score'),
(s11, 'Global Awareness Score', 'Brand Engagement', 'paid_created', 0.90, false, 3, 'score'),
(s11, 'Media Share of Voice (SOV)', 'Brand Engagement', 'paid_created', 0.90, false, 4, 'score'),
(s11, 'Search & Media Interest Index', 'Brand Engagement', 'free_created', 0.90, false, 5, 'score'),
(s11, 'Cultural Relevance Index', 'Brand Engagement', 'free_created', 0.80, false, 6, 'score'),
(s11, 'Heritage & Legacy Score', 'Brand Engagement', 'free_created', 0.90, false, 7, 'score'),
(s11, 'Brand Momentum Index', 'Brand Engagement', 'paid_created', 0.85, false, 8, 'score'),
(s11, 'Brand Health Index (Reputation & Trust)', 'Brand Engagement', 'paid_created', 0.80, false, 9, 'score'),
(s11, 'CSR & Purpose Resonance Score', 'Brand Engagement', 'free_created', 0.80, false, 10, 'score'),
(s11, 'Owned Content Brand Lift', 'Brand Engagement', 'paid_created', 0.85, false, 11, 'score'),
(s11, 'Celebrity & Influencer Association Index', 'Brand Engagement', 'paid_created', 0.80, false, 12, 'score'),
(s11, 'International Licensing Value', 'Brand Engagement', 'paid_created', 0.85, false, 13, 'currency'),
(s11, 'Brand Engagement & Market Presence Composite Score', 'Composite', 'created', 0.95, true, 14, 'score');

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s12, 'Revenue Volatility Index (5yr)', 'Financial Resilience', 'paid_created', 0.90, false, 1, 'score'),
(s12, 'Operating Margin Stability', 'Financial Resilience', 'paid_created', 0.85, false, 2, 'score'),
(s12, 'Leverage & Liquidity Ratio', 'Financial Resilience', 'paid_created', 0.85, false, 3, 'ratio'),
(s12, 'Cash Flow Diversification Index', 'Financial Resilience', 'created', 0.85, false, 4, 'score'),
(s12, 'Salary-to-Revenue Ratio', 'Financial Resilience', 'free_created', 0.90, false, 5, 'percentage'),
(s12, 'Ownership Tenure & Continuity', 'Governance Stability', 'free_created', 0.90, false, 6, 'score'),
(s12, 'Leadership Turnover Rate', 'Governance Stability', 'free_created', 0.85, false, 7, 'score'),
(s12, 'Governance Transparency Score', 'Governance Stability', 'free_created', 0.80, false, 8, 'score'),
(s12, 'Ownership Capital Strength Index', 'Governance Stability', 'paid_created', 0.80, false, 9, 'score'),
(s12, 'Local Market Economic Resilience', 'Market Stability', 'free_created', 0.90, false, 10, 'score'),
(s12, 'Ticket Sales Stability Index', 'Market Stability', 'paid_created', 0.85, false, 11, 'score'),
(s12, 'Long-Term Fan Retention Score', 'Market Stability', 'paid_created', 0.80, false, 12, 'score'),
(s12, 'Structural Revenue Dependence Ratio', 'Operational Predictability', 'created', 0.90, false, 13, 'percentage'),
(s12, 'League Cost Certainty Index', 'Operational Predictability', 'free_created', 0.80, false, 14, 'score'),
(s12, 'Performance-Revenue Correlation (5yr)', 'Performance Volatility', 'free_created', 0.90, false, 15, 'score'),
(s12, 'Structural vs. Event-Driven Growth Ratio', 'Predictability', 'paid_created', 0.85, false, 16, 'score'),
(s12, 'Player Dependence Index', 'Predictability', 'paid_created', 0.80, false, 17, 'score'),
(s12, 'Brand Equity Resilience', 'Predictability', 'paid_created', 0.85, false, 18, 'score'),
(s12, 'Performance Volatility Index', 'Predictability', 'free_created', 0.85, false, 19, 'score'),
(s12, 'Forecast Accuracy Index', 'Predictability', 'paid_created', 0.80, false, 20, 'score'),
(s12, 'Revenue Persistence Ratio', 'Predictability', 'paid_created', 0.85, false, 21, 'score'),
(s12, 'Performance Independence Score', 'Predictability', 'created', 0.90, false, 22, 'score'),
(s12, 'Durability & Predictability Composite Score', 'Composite', 'created', 0.95, true, 23, 'score');

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s13, 'Market Growth Headroom Index', 'Market Expansion', 'free_created', 0.90, false, 1, 'score'),
(s13, 'Geographic Expansion Potential', 'Market Expansion', 'paid_created', 0.85, false, 2, 'score'),
(s13, 'Youth & Demographic Growth Score', 'Market Expansion', 'paid_created', 0.85, false, 3, 'score'),
(s13, 'Digital Fan Base Growth (3-Year CAGR)', 'Digital & Media Growth', 'free_created', 0.95, false, 4, 'percentage'),
(s13, 'Digital Revenue Growth CAGR (3yr)', 'Digital & Media Growth', 'paid_created', 0.90, false, 5, 'percentage'),
(s13, 'OTT & Direct-to-Consumer Potential', 'Digital & Media Growth', 'paid_created', 0.85, false, 6, 'score'),
(s13, 'Social Platform Adoption Delta', 'Digital & Media Growth', 'free_created', 0.90, false, 7, 'score'),
(s13, 'Venue Expansion / Renovation Pipeline', 'Commercial & Real Estate Growth', 'free_created', 0.85, false, 8, 'score'),
(s13, 'Ancillary Development Growth Index', 'Commercial & Real Estate Growth', 'paid_created', 0.85, false, 9, 'score'),
(s13, 'Revenue Mix Scalability Ratio', 'Commercial & Real Estate Growth', 'created', 0.90, false, 10, 'score'),
(s13, 'Valuation Multiple Expansion Potential', 'Financial Upside', 'paid_created', 0.90, false, 11, 'score'),
(s13, 'Operational Leverage Index', 'Financial Upside', 'paid_created', 0.85, false, 12, 'score'),
(s13, 'Innovation Investment Rate', 'Financial Upside', 'free_created', 0.80, false, 13, 'score'),
(s13, 'League Expansion / Structural Upside Index', 'Financial Upside', 'free_created', 0.85, false, 14, 'score'),
(s13, 'International Market Penetration Score', 'Globalization & Brand', 'paid_created', 0.85, false, 15, 'score'),
(s13, 'Brand Globalization Index', 'Globalization & Brand', 'free_created', 0.85, false, 16, 'score'),
(s13, 'Growth Potential Composite Score', 'Composite', 'created', 0.95, true, 17, 'score');

INSERT INTO metrics (section_id, name, category, data_tier, confidence_score, is_composite, display_order, value_type)
VALUES
(s14, 'Self Created vs. Market Delta (%)', 'Market Valuation Alignment', 'paid_created', 0.90, false, 1, 'percentage'),
(s14, 'Valuation Premium Attribution', 'Market Valuation Alignment', 'created', 0.90, false, 2, 'score'),
(s14, 'League Valuation Spread', 'Market Valuation Alignment', 'paid_created', 0.90, false, 3, 'score'),
(s14, 'Cross-League Valuation Gap', 'Market Valuation Alignment', 'paid_created', 0.90, false, 4, 'score'),
(s14, 'Transaction Liquidity Index', 'Transaction & Liquidity', 'free_created', 0.85, false, 5, 'score'),
(s14, 'Investor Recurrence Score', 'Transaction & Liquidity', 'paid_created', 0.85, false, 6, 'score'),
(s14, 'Minority Investment Momentum', 'Transaction & Liquidity', 'paid_created', 0.80, false, 7, 'score'),
(s14, 'Investor Sentiment Index', 'Sentiment & Market Narrative', 'free_created', 0.85, false, 8, 'score'),
(s14, 'Valuation Momentum Index', 'Sentiment & Market Narrative', 'paid_created', 0.85, false, 9, 'score'),
(s14, 'Public Interest Heat Score', 'Sentiment & Market Narrative', 'free_created', 0.90, false, 10, 'score'),
(s14, 'Perceived Growth Premium', 'Sentiment & Market Narrative', 'created', 0.90, false, 11, 'score'),
(s14, 'Market Alignment Composite', 'Composite & Interpretation', 'created', 0.95, false, 12, 'score'),
(s14, 'Premium / Discount to Model (%)', 'Composite & Interpretation', 'created', 0.90, false, 13, 'percentage'),
(s14, 'Investor Confidence Rating (0-100)', 'Composite & Interpretation', 'created', 0.90, false, 14, 'numeric'),
(s14, 'Valuation Multiples & Investor Sentiment Composite Score', 'Composite', 'created', 0.95, true, 15, 'score');

-- ============================================================
-- OKC THUNDER DATA — SECTION I: FINANCIAL
-- ============================================================
INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_base_value, 2024, 2200000000, 'Forbes 2024 NBA valuations');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_applied_value, 2024, 2480000000, 'Base value with brand, growth, and durability adjustments applied');

INSERT INTO team_metric_values (team_id, metric_id, year, value_json, notes)
VALUES (okc_id, m_revenue, 2024, '{"total_usd": 325000000, "yoy_pct": 12.5, "cagr_3yr_pct": 9.2}', 'Forbes estimates; strong growth driven by SGA era');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_ebitda, 2024, 55000000, 'Estimated operating income before interest, taxes, D&A');

INSERT INTO team_metric_values (team_id, metric_id, year, value_json, notes)
VALUES (okc_id, m_ev_multiples, 2024, '{"ev_revenue": 6.77, "ev_ebitda": 40.0}', 'Derived from Base Franchise Value ÷ revenue and EBITDA');

INSERT INTO team_metric_values (team_id, metric_id, year, value_json, notes)
VALUES (okc_id, m_rev_mix, 2024, '{"game_day_pct": 32, "media_pct": 41, "sponsorship_pct": 19, "other_pct": 8}', 'Estimated revenue distribution by category');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_rev_div, 2024, 0.68, 'Moderate diversification; media dependency is primary risk');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fin_vol, 2024, 0.71, 'Relatively stable; COVID-era dip normalized');

INSERT INTO team_metric_values (team_id, metric_id, year, value_text, notes)
VALUES (okc_id, m_cap_debt, 2024, 'Minimal long-term debt; conservative balance sheet under Clay Bennett ownership', 'Per public filings and industry reporting');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_share, 2024, 41.5, 'Approx. 41.5% of total revenue from NBA league distributions');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fin_composite, 2024, 0.82, 'Weighted aggregate of all Section I metrics');

-- ============================================================
-- OKC THUNDER DATA — SECTION II: MARKET
-- ============================================================
INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_mkt_size, 2024, 1396000, 'OKC DMA population per Nielsen 2024');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_median_income, 2024, 57200, 'US Census ACS 2023 estimate; below national median');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_corp_density, 2024, 0.38, 'Devon Energy, Paycom, OGE Energy, Chesapeake HQs present');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_competition_idx, 2024, 0.08, 'Thunder is the only major professional sports franchise in OKC');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_mkt_growth, 2024, 9.2, '10-year cumulative DMA population growth; modest but consistent');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_local_gdp, 2024, 52800, 'BEA Oklahoma City metro GDP per capita 2023');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_mkt_affluence, 2024, 0.53, 'Composite of income, corporate density, GDP per capita, education');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_comp_sat, 2024, 0.12, 'Very low saturation; Thunder has virtually no pro sports competition');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_mkt_stability, 2024, 0.72, 'Oil-dependent economy adds cyclicality risk; strong civic support');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_mkt_composite, 2024, 0.68, 'Weighted aggregate — small but loyal market with monopoly positioning');

-- ============================================================
-- OKC THUNDER DATA — SECTION III: LEAGUE CONTEXT (NBA)
-- ============================================================
INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_cba_term, 2024, 5, 'Current CBA runs through 2029-30 season');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_media_term, 2024, 11, 'ESPN/ABC + NBC + Amazon Prime deal 2025-26 through 2035-36');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_media_val, 2024, 7400000000, 'New NBA media deal ~$76B over 11 years = ~$6.9B/yr blended');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_econ, 2024, 0.88, 'NBA strong economics: growing revenue, healthy margins, no distress teams');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_rev_sharing, 2024, 0.82, 'Robust revenue sharing; significant floor/cap mechanisms protect small markets');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_parity, 2024, 0.74, 'Moderate parity; star clustering remains a structural issue in NBA');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_growth, 2024, 7.2, '5-year NBA revenue CAGR; driven by media rights expansion');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_stability, 2024, 0.85, 'Strong CBA, transparent governance, no relocation threats');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_maturity, 2024, 0.80, 'Mature US market but significant international growth headroom');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_global_reach, 2024, 0.88, 'NBA has ~2B global fans; strongest international reach of US leagues');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_bench, 2024, 0.88, 'NBA leads major US leagues in per-team revenue and valuation multiple');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_league_composite, 2024, 0.85, 'NBA is the highest-rated league context in the framework');

-- ============================================================
-- OKC THUNDER DATA — SECTION VI: GAME DAY ECONOMICS
-- ============================================================
INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_avg_attend, 2024, 18203, '2023-24 season; Paycom Center capacity 18,203 — near capacity all year');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_sellout_rate, 2024, 91.5, '2023-24 season; Thunder among NBA top-10 in attendance consistency');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_ticket_rev, 2024, 68000000, 'Estimated total ticket revenue including suites and club seats');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_atp, 2024, 82.50, 'Weighted average ticket price; below NBA median but rising with team success');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_premium_occ, 2024, 95.0, 'Suite and club seating near fully sold; high corporate demand');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_gameday_yield, 2024, 112, 'Average spend per attendee including tickets, concessions, merchandise');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_concessions, 2024, 18000000, 'Estimated F&B revenue per season; Levy Restaurants is the concessionaire');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_gameday_merch, 2024, 12000000, 'In-venue retail and team store revenue per season');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_sell_through, 2024, 94.2, 'Combined primary + secondary market ticket utilization');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_dyn_pricing, 2024, 0.78, 'Thunder uses Ticketmaster dynamic pricing across most inventory');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_attend_consistency, 2024, 0.88, 'Low year-over-year variance; stable fan base independent of win totals');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_gameday_composite, 2024, 0.83, 'Strong operational execution; upside in ATP vs. NBA peers');

-- ============================================================
-- OKC THUNDER DATA — SECTION X: FAN ENGAGEMENT
-- ============================================================
INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_total_fanbase, 2024, 8500000, 'Aggregate social following: IG ~4.1M, X ~2.3M, TikTok ~1.8M, Facebook ~0.3M');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_social_scale, 2024, 0.42, 'Mid-tier NBA franchise by social scale; smaller market limits ceiling');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_dig_engage, 2024, 5.2, 'Above-average NBA engagement rate; young fanbase drives interaction');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_social_cagr, 2024, 18.5, '3-year CAGR driven by SGA emergence and 2024 playoff run');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fan_retention, 2024, 0.82, 'Strong STH renewal rates; high repeat-attendance frequency');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_loyalty_pen, 2024, 0.65, 'Thunder Loud City loyalty program has moderate enrollment');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fan_sentiment, 2024, 0.78, 'Highly positive; SGA era driving optimism and engagement spike');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fan_advocacy, 2024, 0.74, 'Strong local NPS proxy; Thunder fans among most loyal in NBA per surveys');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_arpf, 2024, 145, 'Estimated annual fan spend across tickets, merch, and content');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_global_fan_dist, 2024, 22.0, '22% of social audience is international; rising with SGA global profile');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_content_consumption, 2024, 18.5, 'Average digital content consumption per fan per month (minutes)');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_age_div, 2024, 0.72, 'Young skewing audience (18-34 dominant); strong long-term sustainability');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fan_tenure, 2024, 0.68, 'Franchise relatively young (2008 relocation); tenure lower than historic franchises');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fan_depth, 2024, 0.76, 'Composite of social engagement, attendance frequency, loyalty behavior');

INSERT INTO team_metric_values (team_id, metric_id, year, value_numeric, notes)
VALUES (okc_id, m_fan_composite, 2024, 0.76, 'Strong engagement metrics offset by smaller absolute scale');

END $$;
