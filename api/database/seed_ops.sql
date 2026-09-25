\c naka_studio;

-- =========================================
-- CONTACTS (semua tipe client)
-- =========================================
INSERT INTO ops.contacts (name, wa, email, source, status, notes) VALUES
-- Active clients
('Budi Santoso', '081234567001', 'budi@astercoffee.id', 'instagram', 'active', 'Owner Aster Coffee, komunikatif'),
('Rina Marlina', '081234567002', 'rina@moriobjects.com', 'referral', 'active', 'Studio owner, udah punya design matang'),
('Dito Firmansyah', '081234567003', 'dito@northline.co', 'direct', 'active', 'Director, butuh company website'),
-- Lead / consultation
('Sari Dewi', '081234567004', 'sari@gmail.com', 'instagram', 'lead', 'UMKM fashion, masih nanya-nanya'),
('Agus Prasetyo', '081234567005', 'agus.prasetyo@gmail.com', 'tiktok', 'lead', 'Modal bayangan, belum tau mau bikin apa'),
-- Prospect (capacity penuh)
('Lena Kusuma', '081234567006', 'lena@lenabakes.com', 'instagram', 'prospect', 'Bakery owner, mau e-commerce'),
-- Inactive
('Reza Aditya', '081234567007', 'reza@gmail.com', 'direct', 'inactive', 'Ghosted setelah quotation dikirim');

-- =========================================
-- PROJECTS (semua status lifecycle)
-- =========================================
INSERT INTO ops.projects (contact_id, package, title, status, capacity_slot, started_at, notes) VALUES
-- CLOSED — project selesai
(1, 'business-website', 'Aster Coffee Website', 'CLOSED', false, '2026-06-01', 'Selesai tepat waktu, client puas'),
-- HANDED_OVER — baru handover
(2, 'custom-website', 'Mori Objects Store', 'HANDED_OVER', false, '2026-07-15', 'Custom e-commerce frontend'),
-- ON — aktif dikerjain (ngambil slot)
(3, 'company-website', 'Northline Company Site', 'ON', true, '2026-09-01', 'Lagi development phase'),
-- REVIEW — nunggu feedback client
(1, 'landing-page', 'Aster Coffee Promo Page', 'REVIEW', true, '2026-09-10', 'Sudah 100% scope, nunggu review'),
-- QUOTATION — belum bayar DP
(4, 'portfolio-website', 'Sari Dewi Portfolio', 'QUOTATION', false, null, 'Quotation sudah dikirim'),
-- CONSULTATION — masih diskusi
(5, 'custom-website', 'Agus Raw Idea Project', 'CONSULTATION', false, null, 'Raw idea flow, masih concept session'),
-- LEAD
(6, 'ecommerce', 'Lena Bakes Shop', 'LEAD', false, null, 'Capacity penuh, masuk prospect dulu');

-- =========================================
-- QUOTATIONS
-- =========================================
INSERT INTO ops.quotations (
  project_id, quotation_number, status, package,
  add_ons, scope_notes, exclusions,
  base_price, addons_price, total_price, currency,
  revision_limit, dp_percentage, final_percentage,
  estimated_duration, estimated_start, estimated_delivery,
  milestones, valid_until, approved_at, notes
) VALUES
-- QT-001: CLOSED project (approved)
(1, 'QT-2026-001', 'approved', 'business-website',
  '["Advanced animation", "Deployment"]',
  'Website bisnis Aster Coffee, 4 halaman utama + blog sederhana',
  'Backend, CMS, hosting',
  3500000, 1500000, 5000000, 'IDR',
  3, 50, 50,
  '14-21 hari kerja', '2026-06-01', '2026-06-15 - 2026-06-22',
  '[{"name":"Project Start","value_pct":0},{"name":"Development","value_pct":60},{"name":"100% Scope","value_pct":80},{"name":"Handover","value_pct":100}]',
  '2026-06-10', '2026-06-01', 'Project pertama bareng Aster Coffee'),

-- QT-002: HANDED_OVER project (approved)
(2, 'QT-2026-002', 'approved', 'custom-website',
  '["Design & Creative Direction", "Advanced animation", "Deployment"]',
  'Custom storefront Mori Objects, 5 halaman, product showcase',
  'Payment gateway, backend inventory',
  5000000, 3000000, 8000000, 'IDR',
  3, 50, 50,
  '21-28 hari kerja', '2026-07-15', '2026-08-05 - 2026-08-12',
  '[{"name":"Project Start","value_pct":0},{"name":"Design","value_pct":20},{"name":"Development","value_pct":70},{"name":"Handover","value_pct":100}]',
  '2026-07-20', '2026-07-15', null),

-- QT-003: ON project (approved)
(3, 'QT-2026-003', 'approved', 'company-website',
  '["Extra page", "Advanced animation"]',
  'Company website Northline, 4 halaman + 1 extra page services',
  'Copywriting, hosting, domain',
  3500000, 1000000, 4500000, 'IDR',
  3, 50, 50,
  '14-21 hari kerja', '2026-09-01', '2026-09-15 - 2026-09-22',
  '[{"name":"Project Start","value_pct":0},{"name":"Development","value_pct":60},{"name":"100% Scope","value_pct":80},{"name":"Handover","value_pct":100}]',
  '2026-09-07', '2026-09-01', 'Lagi jalan'),

-- QT-004: REVIEW project (approved)
(4, 'QT-2026-004', 'approved', 'landing-page',
  '["Extra section"]',
  'Landing page promo Aster Coffee, 5 section + 1 extra',
  'Deployment, hosting',
  1500000, 300000, 1800000, 'IDR',
  3, 50, 50,
  '7-10 hari kerja', '2026-09-10', '2026-09-17 - 2026-09-20',
  '[{"name":"Project Start","value_pct":0},{"name":"Development","value_pct":70},{"name":"Handover","value_pct":100}]',
  '2026-09-15', '2026-09-10', 'Return client'),

-- QT-005: QUOTATION (sent, belum approved)
(5, 'QT-2026-005', 'sent', 'portfolio-website',
  null,
  'Portfolio website Sari Dewi, 4 halaman',
  'Deployment, hosting, domain',
  2500000, 0, 2500000, 'IDR',
  3, 50, 50,
  '10-14 hari kerja', null, null,
  '[{"name":"Project Start","value_pct":0},{"name":"Development","value_pct":65},{"name":"Handover","value_pct":100}]',
  '2026-10-01', null, 'Nunggu approval client');

-- =========================================
-- PAYMENTS
-- =========================================
INSERT INTO ops.payments (
  project_id, quotation_id, type, status, amount, currency,
  method, invoice_number, invoice_sent_at, due_date, paid_at, notes
) VALUES
-- Project 1 (CLOSED) — lunas semua
(1, 1, 'dp', 'paid', 2500000, 'IDR', 'bank_transfer', 'INV-2026-001-DP', '2026-06-01', '2026-06-08', '2026-06-03', 'DP 50%'),
(1, 1, 'final', 'paid', 2500000, 'IDR', 'bank_transfer', 'INV-2026-001-FINAL', '2026-06-22', '2026-06-29', '2026-06-24', 'Pelunasan 50%'),

-- Project 2 (HANDED_OVER) — lunas semua
(2, 2, 'dp', 'paid', 4000000, 'IDR', 'bank_transfer', 'INV-2026-002-DP', '2026-07-15', '2026-07-22', '2026-07-16', 'DP 50%'),
(2, 2, 'final', 'paid', 4000000, 'IDR', 'cash', 'INV-2026-002-FINAL', '2026-08-12', '2026-08-19', '2026-08-14', 'Pelunasan 50%'),

-- Project 3 (ON) — DP paid, final belum
(3, 3, 'dp', 'paid', 2250000, 'IDR', 'bank_transfer', 'INV-2026-003-DP', '2026-09-01', '2026-09-08', '2026-09-02', 'DP 50%'),
(3, 3, 'final', 'unpaid', 2250000, 'IDR', null, 'INV-2026-003-FINAL', null, null, null, 'Belum invoice, nunggu approval'),

-- Project 4 (REVIEW) — DP paid, final belum
(4, 4, 'dp', 'paid', 900000, 'IDR', 'bank_transfer', 'INV-2026-004-DP', '2026-09-10', '2026-09-17', '2026-09-11', 'DP 50%'),
(4, 4, 'final', 'unpaid', 900000, 'IDR', null, 'INV-2026-004-FINAL', null, null, null, 'Nunggu approval client');

-- =========================================
-- ASSET COLLECTIONS
-- =========================================
INSERT INTO ops.asset_collections (project_id, status, deadline, confirmed_complete_at, notes) VALUES
(1, 'complete', '2026-06-05', '2026-06-04', 'Semua asset lengkap'),
(2, 'complete', '2026-07-20', '2026-07-19', 'Semua asset lengkap termasuk foto produk'),
(3, 'complete', '2026-09-05', '2026-09-04', 'Asset lengkap'),
(4, 'complete', '2026-09-12', '2026-09-11', 'Asset promo lengkap');

INSERT INTO ops.asset_items (collection_id, name, status, received_at) VALUES
-- Project 1
(1, 'Logo Aster Coffee', 'received', '2026-06-03'),
(1, 'Foto produk', 'received', '2026-06-03'),
(1, 'Teks copywriting', 'received', '2026-06-04'),
(1, 'Brand color & font', 'received', '2026-06-03'),
-- Project 2
(2, 'Logo Mori Objects', 'received', '2026-07-18'),
(2, 'Foto produk (30 items)', 'received', '2026-07-19'),
(2, 'Deskripsi produk', 'received', '2026-07-19'),
(2, 'Brand guidelines', 'received', '2026-07-18'),
-- Project 3
(3, 'Logo Northline', 'received', '2026-09-03'),
(3, 'Teks halaman About', 'received', '2026-09-04'),
(3, 'Foto tim', 'received', '2026-09-04'),
(3, 'Daftar layanan', 'received', '2026-09-03'),
-- Project 4
(4, 'Materi promo', 'received', '2026-09-11'),
(4, 'Foto produk promo', 'received', '2026-09-11');

-- =========================================
-- REVISIONS
-- =========================================
INSERT INTO ops.revisions (project_id, round_number, status, feedback_batch, submitted_at, deadline, completed_at) VALUES
-- Project 1 (CLOSED) — 2 rounds revisi
(1, 1, 'done', 'Ganti warna tombol CTA, perbesar font heading, tambah padding section hero', '2026-06-16', '2026-06-19', '2026-06-17'),
(1, 2, 'done', 'Foto about section kurang besar, footer perlu tambah link sosmed', '2026-06-19', '2026-06-22', '2026-06-20'),

-- Project 2 (HANDED_OVER) — 3 rounds revisi
(2, 1, 'done', 'Layout product card kurang rapi di mobile, warna background terlalu gelap', '2026-08-06', '2026-08-09', '2026-08-07'),
(2, 2, 'done', 'Animasi hover terlalu cepat, spacing antar section tidak konsisten', '2026-08-09', '2026-08-12', '2026-08-10'),
(2, 3, 'done', 'Final polish: typography size mobile, logo size di navbar', '2026-08-12', '2026-08-14', '2026-08-13'),

-- Project 4 (REVIEW) — round 1 baru masuk
(4, 1, 'submitted', 'Hero section terlalu plain, minta tambah subtle animation. Warna CTA button kurang kontras.', '2026-09-25', '2026-09-28', null);

-- =========================================
-- SCOPE CHANGES
-- =========================================
INSERT INTO ops.scope_changes (project_id, revision_id, description, status, notes) VALUES
(2, 3, 'Client minta tambah halaman FAQ yang tidak ada di scope awal', 'done', 'Diproses sebagai add-on, sudah dibayar'),
(4, 6, 'Client minta tambah section testimonial, di luar scope awal', 'quoted', 'Sudah dibuatkan additional quotation');

-- =========================================
-- CHANGE REQUESTS (post-revision)
-- =========================================
INSERT INTO ops.change_requests (
  project_id, description, scope_notes, fee, currency,
  payment_status, execution_status, requested_at, notes
) VALUES
(1, 'Update foto produk section menu', 'Ganti 3 foto di section menu dengan foto baru dari client', 150000, 'IDR', 'paid', 'done', '2026-07-10', 'Per-request setelah project closed'),
(2, 'Tambah halaman Press / Media', 'Halaman baru untuk press coverage, 1 halaman simple', 500000, 'IDR', 'unpaid', 'pending', '2026-08-20', 'Client belum bayar, tidak dikerjakan');

-- =========================================
-- MAINTENANCE
-- =========================================
INSERT INTO ops.maintenance_contracts (
  project_id, contact_id, type, status,
  is_third_party, audit_done, scope_notes, starts_at, ends_at, notes
) VALUES
(1, 1, 'free_management', 'active', false, false,
  'Bug fix dan small help terkait website Aster Coffee', '2026-06-24', '2026-07-24', 'Free management 1 bulan post-handover'),
(2, 2, 'monthly', 'active', false, false,
  'Update konten produk, minor UI fix, monitoring', '2026-08-14', '2026-09-14', 'Maintenance bulanan Mori Objects');

INSERT INTO ops.maintenance_issues (contract_id, description, attribution, is_warranty, status, resolved_at, notes) VALUES
(1, 'Navbar mobile tidak menutup setelah klik link', 'naka_work', true, 'resolved', '2026-06-28', 'Bug dari code Naka, free warranty'),
(1, 'Client minta ganti warna footer', 'client_action', false, 'resolved', '2026-07-05', 'Bukan bug, diproses sebagai paid request'),
(2, 'Foto produk baru perlu diupload', 'client_action', false, 'resolved', '2026-08-20', 'Rutin update konten monthly');

-- =========================================
-- CONCEPT SESSIONS (Raw Idea flow)
-- =========================================
INSERT INTO ops.concept_sessions (
  contact_id, project_id, status, session_count,
  fee_per_session, total_fee, output_notes
) VALUES
(5, 6, 'concept_session', 2, 150000, 300000,
  'Sudah 2 sesi. Arah: website personal brand + portofolio jasa desain. Masih perlu 1-2 sesi lagi untuk finalisasi struktur.');

-- =========================================
-- PROSPECTS
-- =========================================
INSERT INTO ops.prospects (contact_id, package_interest, status, notes) VALUES
(6, 'ecommerce', 'waiting', 'Capacity penuh, disimpan sebagai prospect. Tertarik e-commerce untuk Lena Bakes.');

-- =========================================
-- ACTIVITY LOG
-- =========================================
INSERT INTO ops.activity_log (project_id, contact_id, type, description, actor, channel) VALUES
(1, 1, 'status_change', 'Project dibuat, status LEAD', 'naka', 'whatsapp'),
(1, 1, 'payment_received', 'DP 50% diterima — Rp 2.500.000', 'naka', 'whatsapp'),
(1, 1, 'status_change', 'Project ON, development dimulai', 'naka', 'system'),
(1, 1, 'status_change', 'Project 100% scope completion, masuk REVIEW', 'naka', 'system'),
(1, 1, 'revision_submitted', 'Client submit revision round 1', 'client', 'whatsapp'),
(1, 1, 'revision_submitted', 'Client submit revision round 2', 'client', 'whatsapp'),
(1, 1, 'approval_received', 'Client approve hasil akhir', 'client', 'whatsapp'),
(1, 1, 'payment_received', 'Final payment diterima — Rp 2.500.000', 'naka', 'whatsapp'),
(1, 1, 'status_change', 'Project CLOSED', 'naka', 'system'),
(3, 3, 'status_change', 'Project ON setelah DP diterima', 'naka', 'system'),
(3, 3, 'payment_received', 'DP 50% diterima — Rp 2.250.000', 'naka', 'whatsapp'),
(4, 1, 'status_change', 'Project masuk REVIEW, nunggu feedback client', 'naka', 'system'),
(4, 1, 'revision_submitted', 'Client submit revision round 1', 'client', 'whatsapp'),
(5, 4, 'note_added', 'Quotation QT-2026-005 dikirim via WhatsApp', 'naka', 'whatsapp'),
(6, 5, 'note_added', 'Concept session ke-2 selesai, arah mulai clear', 'naka', 'whatsapp');