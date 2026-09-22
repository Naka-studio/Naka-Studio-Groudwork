const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const {
  getTestimonials, getFeaturedTestimonials,
  createTestimonial, updateTestimonial, deleteTestimonial
} = require("../controllers/testimonials");

router.get("/", getTestimonials);
router.get("/featured", getFeaturedTestimonials);

router.post("/", verifyToken, createTestimonial);
router.put("/:id", verifyToken, updateTestimonial);
router.delete("/:id", verifyToken, deleteTestimonial);

module.exports = router;