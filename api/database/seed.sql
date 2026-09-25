\c naka_studio;

-- PROJECTS (mock, tetep sama)
INSERT INTO projects (title, category, description, tags, image, featured) VALUES
('Aster Coffee', 'Business Website', 'A warm, editorial storefront for a specialty coffee brand.', '["UI/UX","Frontend","SEO"]', 'https://images.unsplash.com/photo-1445116572660-236099ec97a0?auto=format&fit=crop&w=1600&q=85', true),
('Mori Objects', 'E-commerce', 'A quiet digital home for a small-batch objects studio.', '["Redesign","Frontend"]', 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?auto=format&fit=crop&w=1600&q=85', true),
('Northline', 'Company Website', 'A sharper, clearer presence built around trust and conversion.', '["UI/UX","Frontend","Performance"]', 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=1600&q=85', true);

-- TESTIMONIALS
INSERT INTO testimonials (name, role, company, quote, featured) VALUES
('Dira Kusuma', 'Founder', 'Aster Coffee', 'Naka understood what we were trying to say before we even knew how to say it. The new site finally feels like us.', true),
('Rafi Ananda', 'CEO', 'Mori Objects', 'The attention to detail was unlike anything we had experienced. Every pixel felt intentional.', false),
('Sarah Linton', 'Director', 'Northline', 'Our conversion rate went up within the first week. The new site just makes sense.', false);

-- BLOG POSTS (tetep sama, konten gak berubah)
INSERT INTO blog_posts (slug, category, title, excerpt, read_time, date, featured) VALUES
('kenapa-website-bisnis-kamu-tidak-menghasilkan', 'Conversion',
  '{"en":"Why Your Business Website Isn''t Converting","id":"Kenapa Website Bisnis Kamu Tidak Menghasilkan"}',
  '{"en":"A lot of business websites look fine but do nothing. That''s not a design problem — it''s a direction problem.","id":"Banyak website bisnis terlihat bagus tapi tidak melakukan apa-apa. Ini bukan masalah desain — ini masalah arah."}',
  5, '2026-08-12', true),
('apa-itu-redesign-website-yang-sebenarnya', 'Redesign',
  '{"en":"What a Website Redesign Actually Means","id":"Apa Itu Redesign Website yang Sebenarnya"}',
  '{"en":"A redesign isn''t just a new coat of paint. It''s about understanding why the old version stopped working.","id":"Redesign bukan hanya soal tampilan baru. Ini tentang memahami mengapa yang lama tidak lagi bekerja."}',
  6, '2026-07-28', true),
('ai-dalam-desain-web-bukan-ancaman', 'Design',
  '{"en":"AI in Web Design: Not a Threat, But Not a Solution Either","id":"AI dalam Desain Web: Bukan Ancaman, Tapi Bukan Solusi"}',
  '{"en":"AI can generate. But it doesn''t know your business, your audience, or what makes you different.","id":"AI bisa menghasilkan. Tapi ia tidak tahu bisnis kamu, audience kamu, atau apa yang membuat kamu berbeda."}',
  7, '2026-07-10', false),
('ux-audit-sebelum-redesign', 'UX',
  '{"en":"Do a UX Audit Before You Redesign","id":"Lakukan UX Audit Sebelum Redesign"}',
  '{"en":"Before throwing everything out, understand what''s actually not working — and why.","id":"Sebelum membuang semuanya, pahami dulu apa yang sebenarnya tidak berjalan — dan mengapa."}',
  5, '2026-06-22', false),
('landing-page-vs-website', 'Strategy',
  '{"en":"Landing Page or Website: Which Does Your Business Actually Need?","id":"Landing Page atau Website: Mana yang Bisnis Kamu Butuhkan?"}',
  '{"en":"They serve different purposes. Picking the wrong one wastes time and money.","id":"Keduanya punya fungsi berbeda. Salah pilih bisa buang waktu dan uang."}',
  4, '2026-06-05', false),
('core-web-vitals-untuk-bisnis', 'Performance',
  '{"en":"Core Web Vitals: Why It Actually Matters for Your Business","id":"Core Web Vitals: Kenapa Penting untuk Bisnis Kamu"}',
  '{"en":"It''s not just a technical score. A slow website loses customers before they read a single word.","id":"Bukan hanya soal skor teknis. Website lambat kehilangan pelanggan sebelum mereka membaca satu kata."}',
  6, '2026-05-18', false);

-- PRICING (7 package sesuai agency draft, floating pricing)
INSERT INTO pricing (id, label, starting_from, currency, base_scope, note, sort_order) VALUES
('landing-page',
  '{"en":"Landing Page","id":"Landing Page"}',
  1500000, 'IDR',
  '{"en":["Max 4–5 main sections","Navbar & footer","Responsive","Basic interaction & animation","Frontend development"],"id":["Maks. 4–5 section utama","Navbar & footer","Responsif","Interaksi & animasi dasar","Frontend development"]}',
  '{"en":"Final price depends on scope, complexity, and add-ons.","id":"Harga final tergantung scope, kompleksitas, dan add-ons."}',
  1),
('business-website',
  '{"en":"Business / Company Website","id":"Website Bisnis / Perusahaan"}',
  3500000, 'IDR',
  '{"en":["Max 4 pages","Navbar & footer","Responsive","Basic interaction & animation","Frontend development"],"id":["Maks. 4 halaman","Navbar & footer","Responsif","Interaksi & animasi dasar","Frontend development"]}',
  '{"en":"Final price depends on scope, complexity, and add-ons.","id":"Harga final tergantung scope, kompleksitas, dan add-ons."}',
  2),
('portfolio-website',
  '{"en":"Portfolio Website","id":"Website Portfolio"}',
  2500000, 'IDR',
  '{"en":["Max 4 pages","Navbar & footer","Responsive","Basic interaction & animation","Frontend development"],"id":["Maks. 4 halaman","Navbar & footer","Responsif","Interaksi & animasi dasar","Frontend development"]}',
  '{"en":"Final price depends on scope, complexity, and add-ons.","id":"Harga final tergantung scope, kompleksitas, dan add-ons."}',
  3),
('personal-website',
  '{"en":"Personal / Creator Website","id":"Website Personal / Creator"}',
  2000000, 'IDR',
  '{"en":["Max 4 pages","Navbar & footer","Responsive","Basic interaction & animation","Frontend development"],"id":["Maks. 4 halaman","Navbar & footer","Responsif","Interaksi & animasi dasar","Frontend development"]}',
  '{"en":"Final price depends on scope, complexity, and add-ons.","id":"Harga final tergantung scope, kompleksitas, dan add-ons."}',
  4),
('ecommerce',
  '{"en":"E-commerce","id":"E-commerce"}',
  6000000, 'IDR',
  '{"en":["Max 5 main pages","Product listing & detail","Cart UI","Navbar & footer","Responsive","Basic interaction & animation","Frontend development"],"id":["Maks. 5 halaman utama","Listing & detail produk","UI keranjang","Navbar & footer","Responsif","Interaksi & animasi dasar","Frontend development"]}',
  '{"en":"Final price depends on scope, complexity, and add-ons.","id":"Harga final tergantung scope, kompleksitas, dan add-ons."}',
  5),
('custom-website',
  '{"en":"Custom Website","id":"Website Custom"}',
  5000000, 'IDR',
  '{"en":["Scope defined by project needs","Responsive","Navbar & footer","Basic interaction & animation","Frontend development"],"id":["Scope ditentukan berdasarkan kebutuhan project","Responsif","Navbar & footer","Interaksi & animasi dasar","Frontend development"]}',
  '{"en":"Quoted based on defined scope. Contact us to discuss.","id":"Harga berdasarkan scope yang disepakati. Hubungi kami untuk diskusi."}',
  6),
('website-redesign',
  '{"en":"Website Redesign","id":"Redesign Website"}',
  3000000, 'IDR',
  '{"en":["Quick audit of existing site","Visual & UI redesign","Responsive improvement","Navbar & footer adjustment","Basic interaction & animation","Frontend implementation"],"id":["Audit singkat website existing","Redesign visual & UI","Peningkatan responsif","Penyesuaian navbar & footer","Interaksi & animasi dasar","Implementasi frontend"]}',
  '{"en":"Final price depends on existing site condition and redesign scope.","id":"Harga final tergantung kondisi website existing dan scope redesign."}',
  7);

-- SERVICES (disesuaikan ke scope realistis — pure frontend focus)
INSERT INTO services (id, title, tagline, description_en, description_id, tags, sort_order) VALUES
('01', 'Landing Page', 'One goal. No distractions.',
  'A landing page lives or dies by its focus. We design and build pages around a single outcome — whether that''s a sign-up, a sale, or a conversation.',
  'Landing page hidup atau mati berdasarkan fokusnya. Kami desain dan bangun halaman untuk satu outcome yang jelas — sign-up, penjualan, atau percakapan.',
  '["Frontend","UI/UX","Responsive","Animation"]', 1),
('02', 'Business & Company Website', 'Your business, properly presented.',
  'A professional web presence that communicates what you do, who you are, and why it matters. Built clean, responsive, and ready for real traffic.',
  'Kehadiran web profesional yang mengkomunikasikan apa yang kamu lakukan, siapa kamu, dan kenapa itu penting. Dibangun bersih, responsif, dan siap untuk traffic nyata.',
  '["Frontend","UI/UX","Responsive","Multi-page"]', 2),
('03', 'Portfolio Website', 'Show your work the right way.',
  'A portfolio that doesn''t just display your work — it frames it. Built to make the right impression on the right people.',
  'Portfolio yang tidak hanya menampilkan karya kamu — tapi membingkainya. Dibangun untuk membuat kesan yang tepat kepada orang yang tepat.',
  '["Frontend","UI/UX","Responsive","Personal"]', 3),
('04', 'E-commerce Frontend', 'Storefront built for real buyers.',
  'Product listings, detail pages, cart UI — built clean and responsive. We handle the frontend; you handle the business.',
  'Listing produk, halaman detail, UI keranjang — dibangun bersih dan responsif. Kami urus frontendnya; kamu urus bisnisnya.',
  '["Frontend","UI/UX","Responsive","E-commerce"]', 4),
('05', 'Website Redesign', 'When the old version no longer fits.',
  'Most websites don''t need to be rebuilt from scratch — they need to be rethought. We audit what exists, cut what doesn''t work, and rebuild around what the business actually needs now.',
  'Kebanyakan website tidak perlu dibangun ulang dari nol — tapi perlu dipikirkan ulang. Kami audit yang ada, potong yang tidak bekerja, dan bangun kembali berdasarkan kebutuhan bisnis sekarang.',
  '["Redesign","Frontend","UI/UX","Audit"]', 5),
('06', 'Custom Website', 'Beyond the standard package.',
  'When a project doesn''t fit the standard mold, we build around the actual requirements. Scope defined together, built clean.',
  'Ketika project tidak cocok dengan paket standar, kami bangun berdasarkan kebutuhan aktual. Scope ditentukan bersama, dibangun bersih.',
  '["Frontend","Custom","UI/UX","Responsive"]', 6);

-- AVAILABILITY
INSERT INTO availability (id, status, message) VALUES
(1, 'available', '{"en":"Currently accepting selected projects.","id":"Saat ini menerima beberapa project pilihan."}');

-- CONTACT INFO
INSERT INTO contact_info (id, wa, email, instagram, youtube, linkedin, github, profile_web) VALUES
(1, '08123467890', 'hello@nakastudio.com', 'https://www.instagram.com/', 'https://www.youtube.com/', 'https://www.linkedin.com/', 'https://www.github.com/', 'https://www.bayanaka.dev/');

\c naka_studio;

INSERT INTO ops.capacity_config (id, max_active_slots)
VALUES (1, 3)
ON CONFLICT (id) DO NOTHING;
