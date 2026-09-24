const express = require("express");
const router = express.Router();
const { verifyToken } = require("../../middleware/auth");
const c = require("../../controllers/ops/revisions");

router.get("/project/:project_id", verifyToken, c.getRevisionsByProject);
router.post("/", verifyToken, c.createRevision);
router.patch("/:id/status", verifyToken, c.updateRevisionStatus);

router.get(
  "/scope-changes/project/:project_id",
  verifyToken,
  c.getScopeChangesByProject,
);
router.post("/scope-changes", verifyToken, c.createScopeChange);
router.patch(
  "/scope-changes/:id/status",
  verifyToken,
  c.updateScopeChangeStatus,
);

module.exports = router;
