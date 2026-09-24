const express = require("express");
const router = express.Router();
const { verifyToken } = require("../../middleware/auth");
const c = require("../../controllers/ops/activity");

router.get("/project/:project_id", verifyToken, c.getActivityByProject);
router.post("/", verifyToken, c.logActivity);

module.exports = router;
