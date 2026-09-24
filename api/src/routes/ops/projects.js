const express = require("express");
const router = express.Router();
const verifyToken = require("../../middleware/auth");
const c = require("../../controllers/ops/projects");

router.get("/", verifyToken, c.getProjects);
router.get("/capacity", verifyToken, c.getActiveCapacity);
router.get("/:id", verifyToken, c.getProjectById);
router.post("/", verifyToken, c.createProject);
router.put("/:id", verifyToken, c.updateProjectStatus);
router.delete("/:id", verifyToken, c.deleteProject);

module.exports = router;
