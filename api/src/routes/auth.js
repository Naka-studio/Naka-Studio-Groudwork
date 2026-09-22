const express = require('express')
const router = express.Router()
const { register, login } = require('../controllers/auth')

router.post('/register', register) // nonaktifkan nanti
router.post('/login', login)

module.exports = router