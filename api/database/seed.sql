USE naka_studio;

-- PROJECTS
INSERT INTO projects (title, category, description, tags, image, featured) VALUES
('Aster Coffee', 'Business website', 'A warm, editorial storefront for a specialty coffee brand.', '["UI/UX","Frontend","SEO"]', 'https://images.unsplash.com/photo-1445116572660-236099ec97a0?auto=format&fit=crop&w=1600&q=85', true),
('Mori Objects', 'E-commerce', 'A quiet digital home for a small-batch objects studio.', '["Redesign","Frontend","Copy"]', 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?auto=format&fit=crop&w=1600&q=85', true),
('Northline', 'Professional service', 'A sharper, clearer presence built around trust and conversion.', '["UI/UX","SEO","Performance"]', 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=1600&q=85', true);

-- TESTIMONIALS
INSERT INTO testimonials (name, role, company, quote, featured) VALUES
('Dira Kusuma', 'Founder', 'Aster Coffee', 'Naka understood what we were trying to say before we even knew how to say it. The new site finally feels like us.', true),
('Rafi Ananda', 'CEO', 'Mori Objects', 'The attention to detail was unlike anything we had experienced. Every pixel felt intentional.', false),
('Sarah Linton', 'Director', 'Northline', 'Our conversion rate went up within the first week. The new site just makes sense.', false);

-- BLOG
INSERT INTO blog_posts (slug, category, title, excerpt, read_time, date, featured) VALUES
('kenapa-website-bisnis-kamu-tidak-menghasilkan', 'Conversion',
  '{"en":"Why Your Business Website Isn\'t Converting","id":"Kenapa Website Bisnis Kamu Tidak Menghasilkan"}',
  '{"en":"A lot of business websites look fine but do nothing. That\'s not a design problem — it\'s a direction problem.","id":"Banyak website bisnis terlihat bagus tapi tidak melakukan apa-apa. Ini bukan masalah desain — ini masalah arah."}',
  5, '2026-08-12', true),
('apa-itu-redesign-website-yang-sebenarnya', 'Redesign',
  '{"en":"What a Website Redesign Actually Means","id":"Apa Itu Redesign Website yang Sebenarnya"}',
  '{"en":"A redesign isn\'t just a new coat of paint. It\'s about understanding why the old version stopped working.","id":"Redesign bukan hanya soal tampilan baru. Ini tentang memahami mengapa yang lama tidak lagi bekerja."}',
  6, '2026-07-28', true),
('ai-dalam-desain-web-bukan-ancaman', 'Design',
  '{"en":"AI in Web Design: Not a Threat, But Not a Solution Either","id":"AI dalam Desain Web: Bukan Ancaman, Tapi Bukan Solusi"}',
  '{"en":"AI can generate. But it doesn\'t know your business, your audience, or what makes you different.","id":"AI bisa menghasilkan. Tapi ia tidak tahu bisnis kamu, audience kamu, atau apa yang membuat kamu berbeda."}',
  7, '2026-07-10', false),
('ux-audit-sebelum-redesign', 'UX',
  '{"en":"Do a UX Audit Before You Redesign","id":"Lakukan UX Audit Sebelum Redesign"}',
  '{"en":"Before throwing everything out, understand what\'s actually not working — and why.","id":"Sebelum membuang semuanya, pahami dulu apa yang sebenarnya tidak berjalan — dan mengapa."}',
  5, '2026-06-22', false),
('landing-page-vs-website', 'Strategy',
  '{"en":"Landing Page or Website: Which Does Your Business Actually Need?","id":"Landing Page atau Website: Mana yang Bisnis Kamu Butuhkan?"}',
  '{"en":"They serve different purposes. Picking the wrong one wastes time and money.","id":"Keduanya punya fungsi berbeda. Salah pilih bisa buang waktu dan uang."}',
  4, '2026-06-05', false),
('core-web-vitals-untuk-bisnis', 'Performance',
  '{"en":"Core Web Vitals: Why It Actually Matters for Your Business","id":"Core Web Vitals: Kenapa Penting untuk Bisnis Kamu"}',
  '{"en":"It\'s not just a technical score. A slow website loses customers before they read a single word.","id":"Bukan hanya soal skor teknis. Website lambat kehilangan pelanggan sebelum mereka membaca satu kata."}',
  6, '2026-05-18', false);

-- AVAILABILITY
INSERT INTO availability (id, status, message) VALUES
(1, 'available', '{"en":"Currently accepting selected projects.","id":"Saat ini menerima beberapa project pilihan."}');

-- CONTACT
INSERT INTO contact_info (id, wa, email, instagram, youtube, linkedin, github, profile_web) VALUES
(1, '08123467890', 'hello@nakastudio.com', 'https://www.instagram.com/', 'https://www.youtube.com/', 'https://www.linkedin.com/', 'https://www.github.com/', 'https://www.bayanaka.dev/');
