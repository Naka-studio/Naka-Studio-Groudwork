const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const db = require('../config/db')

// SEKALI PAKAI — nonaktifkan setelah admin dibuat
exports.register = async (req, res) => {
  const { email, password } = req.body
  try {
    const hash = await bcrypt.hash(password, 10)
    await db.query('INSERT INTO users (email, password) VALUES (?, ?)', [email, hash])
    res.json({ success: true, message: 'Admin created' })
  } catch (err) {
    res.status(500).json({ success: false, message: err.message })
  }
}

exports.login = async (req, res) => {
  const { email, password } = req.body
  try {
    const [rows] = await db.query('SELECT * FROM users WHERE email = ?', [email])
    if (!rows.length) return res.status(401).json({ success: false, message: 'Invalid credentials' })

    const valid = await bcrypt.compare(password, rows[0].password)
    if (!valid) return res.status(401).json({ success: false, message: 'Invalid credentials' })

    const token = jwt.sign(
      { id: rows[0].id, email: rows[0].email },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
    )
    res.json({ success: true, token })
  } catch (err) {
    res.status(500).json({ success: false, message: err.message })
  }
}