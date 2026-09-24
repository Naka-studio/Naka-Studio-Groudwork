const express = require("express");
const router = express.Router();
const verifyToken = require("../../middleware/auth");
const c = require("../../controllers/ops/payments");

router.get("/", verifyToken, c.getPayments);
router.get("/project/:project_id", verifyToken, c.getPaymentsByProject);
router.post("/", verifyToken, c.createPayment);
router.patch("/:id/status", verifyToken, c.updatePaymentStatus);

module.exports = router;
