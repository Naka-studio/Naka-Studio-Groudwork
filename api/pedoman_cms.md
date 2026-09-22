# CMS Naka Studio — Pedoman Lengkap

> Stack: Express + MySQL + React (Vite). Referensi untuk sesi pengerjaan CMS.

---

## 1. Yang Perlu Dimanage

### Konten (full CRUD)
- **Projects** — tambah/edit/hapus portfolio, upload image
- **Blog Posts** — tulis/edit/hapus artikel, bilingual (en + id), rich text editor
- **Testimonials** — tambah/edit/hapus testimoni, toggle featured
- **Pricing** — update harga & paket, includes list per bahasa
- **Services** — edit deskripsi en & id, urutan sort_order

### Config (update only)
- **Availability** — toggle status (available / limited / unavailable)
- **Contact Info** — update WA, email, sosial media links

### Inbox (read + delete)
- **Contact Messages** — lihat pesan masuk, hapus yang sudah dibaca

---

## 2. Auth

Single admin user, JWT-based.

### Tabel baru
```sql
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Package
- bcryptjs
- jsonwebtoken

### Endpoint
- POST /api/auth/login
- POST /api/auth/register (sekali pakai, nonaktifkan setelah buat admin)

### Middleware verifyToken
```js
// src/middleware/auth.js
const jwt = require('jsonwebtoken')

const verifyToken = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1]
  if (!token) return res.status(401).json({ success: false })
  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ success: false })
    req.user = user
    next()
  })
}

module.exports = verifyToken
```

---

## 3. Endpoint yang Perlu Ditambah

### Projects
- POST   /api/projects
- PUT    /api/projects/:id
- DELETE /api/projects/:id

### Blog
- POST   /api/blog
- PUT    /api/blog/:id
- DELETE /api/blog/:id

### Testimonials
- POST   /api/testimonials
- PUT    /api/testimonials/:id
- DELETE /api/testimonials/:id

### Pricing
- POST   /api/pricing
- PUT    /api/pricing/:id
- DELETE /api/pricing/:id

### Services
- PUT    /api/services/:id

### Availability
- PUT    /api/availability

### Contact Info
- PUT    /api/contact

### Contact Messages
- GET    /api/contact/messages
- DELETE /api/contact/messages/:id

> Semua endpoint CMS wajib pakai middleware verifyToken.

---

## 4. Stack CMS Frontend

### Rekomendasi: React + Vite (Opsi A)
- Folder terpisah: naka-studio-cms/
- Port: 5174
- Route: /login, /dashboard, /projects, /blog, /testimonials, /pricing, /services, /messages

---

## 5. Fitur per Halaman

### Dashboard
- Ringkasan: jumlah projects, posts, pesan baru
- Toggle availability langsung
- Notif pesan masuk belum dibaca

### Blog Editor
- Rich text: @tiptap/react
- Input bilingual: tab EN / ID
- Field: slug (auto dari title), category, read_time, date, featured toggle

### Projects
- Form: title, category, description, tags, image URL, featured toggle
- Upload image: multer + static file serving

### Pricing & Services
- Inline edit per field
- Pricing includes: drag-to-reorder (opsional)

---

## 6. ENV Tambahan

```env
JWT_SECRET=your_random_secret_string
JWT_EXPIRES_IN=7d
```

---

## 7. Urutan Pengerjaan

1. Setup auth backend (tabel users, login endpoint, middleware)
2. Tambah semua endpoint CRUD + pasang verifyToken
3. Init naka-studio-cms (Vite + React)
4. Halaman login + simpan JWT ke localStorage
5. Dashboard + layout sidebar
6. CRUD Projects & Blog duluan
7. Blog editor dengan Tiptap
8. Inbox contact messages