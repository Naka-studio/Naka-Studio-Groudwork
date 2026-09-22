const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const { getAvailability, updateAvailability } = require("../controllers/availability");

router.get("/", getAvailability);
router.put("/", verifyToken, updateAvailability);

module.exports = router;