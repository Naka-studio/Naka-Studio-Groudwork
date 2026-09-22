const express = require('express')
const router = express.Router()
const verifyToken = require('../middleware/auth')
const {
  getContact, submitContact,
  updateContact, getMessages, deleteMessage
} = require('../controllers/contact')

// Public
router.get('/', getContact)
router.post('/submit', submitContact)

// Protected
router.put('/', verifyToken, updateContact)
router.get('/messages', verifyToken, getMessages)
router.delete('/messages/:id', verifyToken, deleteMessage)

module.exports = router