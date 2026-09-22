const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const {
  getProjects,
  getFeaturedProjects,
  getProjectById,
  createProject,
  updateProject,
  deleteProject,
} = require("../controllers/projects");

// Public
router.get("/", getProjects);
router.get("/featured", getFeaturedProjects);
router.get("/:id", getProjectById);

// Protected
router.post("/", verifyToken, createProject);
router.put("/:id", verifyToken, updateProject);
router.delete("/:id", verifyToken, deleteProject);

module.exports = router;