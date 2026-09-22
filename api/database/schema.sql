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

-- BLOG POSTS (title & excerpt bilingual via JSONB)
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

-- PRICING (label & includes bilingual via JSONB)
CREATE TABLE pricing (
  id VARCHAR(100) PRIMARY KEY,
  label JSONB NOT NULL,
  starting_from INT NOT NULL,
  currency VARCHAR(10) DEFAULT 'IDR',
  includes JSONB,
  sort_order INT DEFAULT 0
);

-- SERVICES (description dipisah per bahasa)
CREATE TABLE services (
  id VARCHAR(10) PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  tagline VARCHAR(255),
  description_en TEXT,
  description_id TEXT,
  tags JSONB,
  sort_order INT DEFAULT 0
);

-- AVAILABILITY (1 row config)
CREATE TABLE availability (
  id INT PRIMARY KEY DEFAULT 1,
  status VARCHAR(20) DEFAULT 'available',
  message JSONB,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CONTACT INFO (1 row config)
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

-- CONTACT MESSAGES (inbox form)
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
