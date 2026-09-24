-- schema.sql (naka_studio — public DB)

CREATE DATABASE naka_studio;
\c naka_studio;

-- PROJECTS
CREATE TABLE projects (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  category VARCHAR(100),
  description TEXT,
  tags JSONB,
  image VARCHAR(500),
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TESTIMONIALS
CREATE TABLE testimonials (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(100),
  company VARCHAR(100),
  quote TEXT,
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BLOG POSTS
CREATE TABLE blog_posts (
  id SERIAL PRIMARY KEY,
  slug VARCHAR(255) UNIQUE NOT NULL,
  category VARCHAR(100),
  title JSONB NOT NULL,
  excerpt JSONB,
  content_en TEXT,
  content_id TEXT,
  read_time INT,
  date DATE,
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PRICING
-- Floating pricing: starting_from = base/threshold, bukan harga final
-- base_scope = deskripsi singkat apa yang termasuk base package
-- note = catatan tambahan (misal "harga final tergantung scope")
CREATE TABLE pricing (
  id VARCHAR(100) PRIMARY KEY,
  label JSONB NOT NULL,
  starting_from INT NOT NULL,
  currency VARCHAR(10) DEFAULT 'IDR',
  base_scope JSONB,
  note JSONB,
  sort_order INT DEFAULT 0
);

-- SERVICES
-- Disesuaikan ke scope realistis Naka Studio (pure frontend focus)
CREATE TABLE services (
  id VARCHAR(10) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  tagline VARCHAR(255),
  description_en TEXT,
  description_id TEXT,
  tags JSONB,
  sort_order INT DEFAULT 0
);

-- AVAILABILITY
CREATE TABLE availability (
  id INT PRIMARY KEY DEFAULT 1,
  status VARCHAR(20) DEFAULT 'available',
  message JSONB,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CONTACT INFO
CREATE TABLE contact_info (
  id INT PRIMARY KEY DEFAULT 1,
  wa VARCHAR(20),
  email VARCHAR(100),
  instagram VARCHAR(255),
  youtube VARCHAR(255),
  linkedin VARCHAR(255),
  github VARCHAR(255),
  profile_web VARCHAR(255),
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CONTACT MESSAGES
CREATE TABLE contact_messages (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CMS ADMIN
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =========================================
-- OPS SCHEMA (internal operasional)
-- =========================================
CREATE SCHEMA ops;

-- 1. CONTACTS
CREATE TABLE ops.contacts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  wa VARCHAR(20),
  email VARCHAR(100),
  source VARCHAR(100),
  status VARCHAR(50) DEFAULT 'lead',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. PROJECTS
CREATE TABLE ops.projects (
  id SERIAL PRIMARY KEY,
  contact_id INT REFERENCES ops.contacts(id),
  package VARCHAR(100) NOT NULL,
  title VARCHAR(255),
  status VARCHAR(50) DEFAULT 'LEAD',
  capacity_slot BOOLEAN DEFAULT false,
  started_at TIMESTAMP,
  closed_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. QUOTATIONS
CREATE TABLE ops.quotations (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  quotation_number VARCHAR(50) UNIQUE NOT NULL,
  status VARCHAR(50) DEFAULT 'draft',
  package VARCHAR(100),
  add_ons JSONB,
  scope_notes TEXT,
  exclusions TEXT,
  complexity_notes TEXT,
  base_price INT NOT NULL,
  addons_price INT DEFAULT 0,
  total_price INT NOT NULL,
  currency VARCHAR(10) DEFAULT 'IDR',
  revision_limit INT DEFAULT 3,
  dp_percentage INT DEFAULT 50,
  final_percentage INT DEFAULT 50,
  estimated_duration VARCHAR(100),
  estimated_start DATE,
  estimated_delivery VARCHAR(100),
  milestones JSONB,
  valid_until DATE,
  approved_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. PAYMENTS
CREATE TABLE ops.payments (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  quotation_id INT REFERENCES ops.quotations(id),
  type VARCHAR(20) NOT NULL,
  status VARCHAR(20) DEFAULT 'unpaid',
  amount INT NOT NULL,
  currency VARCHAR(10) DEFAULT 'IDR',
  method VARCHAR(50),
  invoice_number VARCHAR(50) UNIQUE,
  invoice_sent_at TIMESTAMP,
  due_date DATE,
  paid_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. ASSET COLLECTION
CREATE TABLE ops.asset_collections (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  status VARCHAR(50) DEFAULT 'pending',
  deadline DATE,
  confirmed_complete_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ops.asset_items (
  id SERIAL PRIMARY KEY,
  collection_id INT REFERENCES ops.asset_collections(id),
  name VARCHAR(255) NOT NULL,
  status VARCHAR(50) DEFAULT 'missing',
  notes TEXT,
  received_at TIMESTAMP
);

-- 6. REVISIONS
CREATE TABLE ops.revisions (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  round_number INT NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  feedback_batch TEXT,
  submitted_at TIMESTAMP,
  deadline DATE,
  completed_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ops.scope_changes (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  revision_id INT REFERENCES ops.revisions(id),
  description TEXT NOT NULL,
  status VARCHAR(50) DEFAULT 'pending',
  additional_quotation_id INT REFERENCES ops.quotations(id),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. CHANGE REQUESTS
CREATE TABLE ops.change_requests (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  description TEXT NOT NULL,
  scope_notes TEXT,
  fee INT,
  currency VARCHAR(10) DEFAULT 'IDR',
  payment_status VARCHAR(50) DEFAULT 'unpaid',
  execution_status VARCHAR(50) DEFAULT 'pending',
  payment_id INT REFERENCES ops.payments(id),
  requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP,
  notes TEXT
);

-- 8. MAINTENANCE
CREATE TABLE ops.maintenance_contracts (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  contact_id INT REFERENCES ops.contacts(id),
  type VARCHAR(50) NOT NULL,
  status VARCHAR(50) DEFAULT 'active',
  is_third_party BOOLEAN DEFAULT false,
  audit_done BOOLEAN DEFAULT false,
  scope_notes TEXT,
  starts_at DATE,
  ends_at DATE,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ops.maintenance_issues (
  id SERIAL PRIMARY KEY,
  contract_id INT REFERENCES ops.maintenance_contracts(id),
  description TEXT NOT NULL,
  attribution VARCHAR(50),
  is_warranty BOOLEAN DEFAULT false,
  status VARCHAR(50) DEFAULT 'open',
  payment_id INT REFERENCES ops.payments(id),
  resolved_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. CONCEPT SESSIONS
CREATE TABLE ops.concept_sessions (
  id SERIAL PRIMARY KEY,
  contact_id INT REFERENCES ops.contacts(id),
  project_id INT REFERENCES ops.projects(id),
  status VARCHAR(50) DEFAULT 'free_consultation',
  session_count INT DEFAULT 0,
  fee_per_session INT DEFAULT 0,
  total_fee INT DEFAULT 0,
  payment_id INT REFERENCES ops.payments(id),
  output_notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. CAPACITY
CREATE TABLE ops.capacity_config (
  id INT PRIMARY KEY DEFAULT 1,
  max_active_slots INT DEFAULT 2,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE VIEW ops.active_capacity AS
SELECT
  (SELECT max_active_slots FROM ops.capacity_config WHERE id = 1) AS max_slots,
  COUNT(*)::int AS used_slots,
  ((SELECT max_active_slots FROM ops.capacity_config WHERE id = 1) - COUNT(*))::int AS available_slots
FROM ops.projects
WHERE capacity_slot = true
  AND status NOT IN ('CLOSED', 'MAINTENANCE');

-- 11. PROSPECTS
CREATE TABLE ops.prospects (
  id SERIAL PRIMARY KEY,
  contact_id INT REFERENCES ops.contacts(id),
  package_interest VARCHAR(100),
  notes TEXT,
  status VARCHAR(50) DEFAULT 'waiting',
  notified_at TIMESTAMP,
  claim_deadline TIMESTAMP,
  converted_to_project_id INT REFERENCES ops.projects(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 12. ACTIVITY LOG
CREATE TABLE ops.activity_log (
  id SERIAL PRIMARY KEY,
  project_id INT REFERENCES ops.projects(id),
  contact_id INT REFERENCES ops.contacts(id),
  type VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  actor VARCHAR(100) DEFAULT 'naka',
  channel VARCHAR(50),
  metadata JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);