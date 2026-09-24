const express = require("express");
const router = express.Router();
const { verifyToken } = require("../../middleware/auth");
const c = require("../../controllers/ops/quotations");

router.get("/", verifyToken, c.getQuotations);
router.get("/project/:project_id", verifyToken, c.getQuotationsByProject);
router.get("/:id", verifyToken, c.getQuotationById);
router.post("/", verifyToken, c.createQuotation);
router.patch("/:id/status", verifyToken, c.updateQuotationStatus);
router.delete("/:id", verifyToken, c.deleteQuotation);

module.exports = router;
