const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const {
  getPosts,
  getFeaturedPosts,
  getPostBySlug,
  getPostsByCategory,
  createPost,
  updatePost,
  deletePost,
} = require("../controllers/blog");

// Public
router.get("/", getPosts);
router.get("/featured", getFeaturedPosts);
router.get("/category/:category", getPostsByCategory);
router.get("/:slug", getPostBySlug);

// Protected
router.post("/", verifyToken, createPost);
router.put("/:id", verifyToken, updatePost);
router.delete("/:id", verifyToken, deletePost);

module.exports = router;