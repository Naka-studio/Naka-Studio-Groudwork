const express = require("express");
const router = express.Router();
const { verifyToken } = require("../../middleware/auth");
const c = require("../../controllers/ops/contacts");

router.get("/", verifyToken, c.getContacts);
router.get("/:id", verifyToken, c.getContactById);
router.post("/", verifyToken, c.createContact);
router.put("/:id", verifyToken, c.updateContact);
router.delete("/:id", verifyToken, c.deleteContact);

module.exports = router;
