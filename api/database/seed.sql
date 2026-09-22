\c naka_studio;

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

-- PRICING
INSERT INTO pricing (id, label, starting_from, currency, includes, sort_order) VALUES
('landing-page', '{"en":"Landing Page","id":"Landing Page"}', 1500000, 'IDR', '{"en":["1-page responsive design","UI/UX design","Frontend development","Basic SEO setup","Contact form or CTA integration","1 revision round"],"id":["Desain responsif 1 halaman","Desain UI/UX","Frontend development","Setup SEO dasar","Integrasi form atau CTA","1 putaran revisi"]}', 1),
('personal-website', '{"en":"Personal Website","id":"Website Personal"}', 2500000, 'IDR', '{"en":["Up to 4 pages","UI/UX design","Frontend development","Basic SEO setup","Mobile-first responsive","Social links & contact section","2 revision rounds"],"id":["Hingga 4 halaman","Desain UI/UX","Frontend development","Setup SEO dasar","Responsif mobile-first","Social links & section kontak","2 putaran revisi"]}', 2),
('company-website', '{"en":"Company Website","id":"Website Perusahaan"}', 5000000, 'IDR', '{"en":["Up to 8 pages","UI/UX design","Frontend development","SEO foundation","Conversion copywriting","Mobile-first responsive","Performance optimization","3 revision rounds"],"id":["Hingga 8 halaman","Desain UI/UX","Frontend development","Fondasi SEO","Copywriting konversi","Responsif mobile-first","Optimasi performa","3 putaran revisi"]}', 3),
('ecommerce-frontend', '{"en":"E-commerce Frontend","id":"Frontend E-commerce"}', 8000000, 'IDR', '{"en":["Custom storefront design","UI/UX design","Frontend development","Product listing & detail pages","Cart & checkout UI","SEO foundation","Performance optimization","Mobile-first responsive","3 revision rounds"],"id":["Desain storefront custom","Desain UI/UX","Frontend development","Halaman listing & detail produk","UI keranjang & checkout","Fondasi SEO","Optimasi performa","Responsif mobile-first","3 putaran revisi"]}', 4),
('redesign', '{"en":"Website Redesign","id":"Redesign Website"}', 3000000, 'IDR', '{"en":["UX audit of existing site","New UI/UX design direction","Frontend rebuild","SEO preservation","Performance optimization","Mobile-first responsive","2 revision rounds"],"id":["Audit UX website yang ada","Arah desain UI/UX baru","Rebuild frontend","Preservasi SEO","Optimasi performa","Responsif mobile-first","2 putaran revisi"]}', 5);

-- SERVICES
INSERT INTO services (id, title, tagline, description_en, description_id, tags, sort_order) VALUES
('01', 'UI / UX Design', 'Interfaces shaped around people.', 'Good design isn''t decoration — it''s direction. We build interfaces that make the next step obvious, reduce friction, and reflect the real context of the people using them.', 'Desain yang baik bukan sekadar dekorasi — tapi arah. Kami membangun interface yang membuat langkah berikutnya terasa jelas, mengurangi hambatan, dan mencerminkan konteks nyata penggunanya.', '["Research","Wireframe","UI","Prototype"]', 1),
('02', 'Frontend Development', 'Code that actually ships clean.', 'Responsive, performant, and maintainable frontends built with modern tools. We write code like someone else will have to read it — because they will.', 'Frontend yang responsif, performant, dan maintainable dengan tools modern. Kami menulis kode seolah orang lain yang harus membacanya — karena memang begitu.', '["React","Vite","SCSS","Performance"]', 2),
('03', 'Website Redesign', 'When the old version no longer fits.', 'Most websites don''t need to be rebuilt from scratch — they need to be rethought. We identify what''s working, cut what isn''t, and rebuild around what the business actually needs now.', 'Kebanyakan website tidak perlu dibangun ulang dari nol — tapi perlu dipikirkan ulang. Kami identifikasi yang masih bekerja, potong yang tidak, dan bangun kembali berdasarkan kebutuhan bisnis yang sebenarnya.', '["Audit","UX","Redesign","Migration"]', 3),
('04', 'SEO + Copywriting', 'Found by the right people. Read by humans.', 'Technical SEO foundations and copy that earns attention. We write for search engines without forgetting that real people have to actually read it.', 'Fondasi SEO teknis dan copy yang layak dibaca. Kami menulis untuk search engine tanpa lupa bahwa manusia nyata yang harus membacanya.', '["On-page SEO","Copy","Meta","Structure"]', 4),
('05', 'Landing Pages', 'One goal. No distractions.', 'A landing page lives or dies by its focus. We design and build focused pages around a single outcome — whether that''s a sign-up, a sale, or a conversation.', 'Landing page hidup atau mati berdasarkan fokusnya. Kami desain dan bangun halaman fokus untuk satu outcome yang jelas — sign-up, penjualan, atau percakapan.', '["Conversion","Copy","UI","A/B Ready"]', 5),
('06', 'Performance Optimization', 'Faster is a feature.', 'Slow websites lose people before they''ve read a word. We audit, diagnose, and fix — Core Web Vitals, load time, image handling, render-blocking resources, and more.', 'Website lambat kehilangan pengunjung sebelum mereka membaca satu kata pun. Kami audit, diagnosis, dan perbaiki — Core Web Vitals, load time, image handling, render-blocking resources, dan lainnya.', '["Core Web Vitals","Lighthouse","Images","Bundles"]', 6),
('07', 'UI / UX Audit', 'A second pair of eyes on what you''ve built.', 'We review your existing website and identify where users are likely getting confused, frustrated, or lost — then give you a clear picture of what to fix and why.', 'Kami review website kamu dan identifikasi di mana pengguna kemungkinan besar bingung, frustrasi, atau hilang arah — lalu kasih gambaran jelas apa yang perlu diperbaiki dan kenapa.', '["Heuristics","UX Review","Report","Recommendations"]', 7),
('08', 'Design Systems', 'Build once. Use everywhere.', 'When a project needs consistency at scale, we build reusable visual and component foundations that make future work faster and more coherent.', 'Ketika project butuh konsistensi di skala besar, kami bangun fondasi visual dan komponen yang reusable — biar pekerjaan berikutnya lebih cepat dan lebih koheren.', '["Tokens","Components","Documentation","Figma"]', 8);

-- AVAILABILITY
INSERT INTO availability (id, status, message) VALUES
(1, 'available', '{"en":"Currently accepting selected projects.","id":"Saat ini menerima beberapa project pilihan."}');

-- CONTACT
INSERT INTO contact_info (id, wa, email, instagram, youtube, linkedin, github, profile_web) VALUES
(1, '08123467890', 'hello@nakastudio.com', 'https://www.instagram.com/', 'https://www.youtube.com/', 'https://www.linkedin.com/', 'https://www.github.com/', 'https://www.bayanaka.dev/');
