CREATE DATABASE IF NOT EXISTS naka_studio;
USE naka_studio;

-- =====================
-- PROJECTS
-- =====================
CREATE TABLE projects (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  category VARCHAR(100),
  description TEXT,
  tags JSON,
  image VARCHAR(500),
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================
-- TESTIMONIALS
-- =====================
CREATE TABLE testimonials (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(100),
  company VARCHAR(100),
  quote TEXT,
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================
-- BLOG POSTS
-- =====================
CREATE TABLE blog_posts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  slug VARCHAR(255) UNIQUE NOT NULL,
  category VARCHAR(100),
  title JSON NOT NULL,      -- { "en": "...", "id": "..." }
  excerpt JSON,             -- { "en": "...", "id": "..." }
  read_time INT,
  date DATE,
  featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================
-- PRICING
-- =====================
CREATE TABLE pricing (
  id VARCHAR(100) PRIMARY KEY,   -- "landing-page", "company-website", dll
  label JSON NOT NULL,           -- { "en": "...", "id": "..." }
  starting_from INT NOT NULL,
  currency VARCHAR(10) DEFAULT 'IDR',
  includes JSON,                 -- { "en": [...], "id": [...] }
  sort_order INT DEFAULT 0
);

-- =====================
-- SERVICES
-- =====================
CREATE TABLE services (
  id VARCHAR(10) PRIMARY KEY,    -- "01", "02", dst
  title VARCHAR(255) NOT NULL,
  tagline VARCHAR(255),
  description_en TEXT,
  description_id TEXT,
  tags JSON,
  sort_order INT DEFAULT 0
);

-- =====================
-- AVAILABILITY (config, 1 row)
-- =====================
CREATE TABLE availability (
  id INT PRIMARY KEY DEFAULT 1,
  status ENUM('available', 'limited', 'unavailable') DEFAULT 'available',
  message JSON,   -- { "en": "...", "id": "..." }
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =====================
-- CONTACT (config, 1 row)
-- =====================
CREATE TABLE contact_info (
  id INT PRIMARY KEY DEFAULT 1,
  wa VARCHAR(20),
  email VARCHAR(100),
  instagram VARCHAR(255),
  youtube VARCHAR(255),
  linkedin VARCHAR(255),
  github VARCHAR(255),
  profile_web VARCHAR(255),
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =====================
-- CMS ADMIN
-- =====================
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);