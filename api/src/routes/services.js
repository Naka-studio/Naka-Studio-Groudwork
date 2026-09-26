const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const { getServices, getServiceById, updateService, updateAvailability } = require("../controllers/services");

router.get("/", getServices);
router.get("/:id", getServiceById);

router.put("/:id", verifyToken, updateService);
router.put('/:id/availability', verifyToken, updateAvailability)

module.exports = router;