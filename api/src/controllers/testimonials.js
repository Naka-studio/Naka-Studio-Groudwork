const pool = require("../config/db");

const getTestimonials = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM testimonials ORDER BY id ASC",
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getFeaturedTestimonials = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM testimonials WHERE featured = true",
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const createTestimonial = async (req, res, next) => {
  const { name, role, company, quote, featured } = req.body;
  try {
    const { rows } = await pool.query(
      "INSERT INTO testimonials (name, role, company, quote, featured) VALUES ($1, $2, $3, $4, $5) RETURNING id",
      [name, role, company, quote, featured ?? false],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateTestimonial = async (req, res, next) => {
  const { name, role, company, quote, featured } = req.body;
  try {
    const { rowCount } = await pool.query(
      "UPDATE testimonials SET name=$1, role=$2, company=$3, quote=$4, featured=$5 WHERE id=$6",
      [name, role, company, quote, featured ?? false, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Testimonial not found" });
    res.json({ success: true, message: "Testimonial updated" });
  } catch (err) {
    next(err);
  }
};

const deleteTestimonial = async (req, res, next) => {
  try {
    const { rowCount } = await pool.query(
      "DELETE FROM testimonials WHERE id=$1",
      [req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Testimonial not found" });
    res.json({ success: true, message: "Testimonial deleted" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getTestimonials,
  getFeaturedTestimonials,
  createTestimonial,
  updateTestimonial,
  deleteTestimonial,
};
