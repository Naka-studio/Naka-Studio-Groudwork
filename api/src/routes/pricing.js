const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const {
  getPricing, getPricingById,
  createPricing, updatePricing, deletePricing
} = require("../controllers/pricing");

router.get("/", getPricing);
router.get("/:id", getPricingById);

router.post("/", verifyToken, createPricing);
router.put("/:id", verifyToken, updatePricing);
router.delete("/:id", verifyToken, deletePricing);

module.exports = router;