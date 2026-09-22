const pool = require("../config/db");

const getTestimonials = async (req, res, next) => {
	try {
		const [rows] = await pool.query(
			"SELECT * FROM testimonials ORDER BY id ASC",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const getFeaturedTestimonials = async (req, res, next) => {
	try {
		const [rows] = await pool.query(
			"SELECT * FROM testimonials WHERE featured = 1",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const createTestimonial = async (req, res, next) => {
  const { name, role, company, quote, featured } = req.body;
  try {
    const [result] = await pool.query(
      "INSERT INTO testimonials (name, role, company, quote, featured) VALUES (?, ?, ?, ?, ?)",
      [name, role, company, quote, featured ?? 0]
    );
    res.status(201).json({ success: true, id: result.insertId });
  } catch (err) { next(err) }
};

const updateTestimonial = async (req, res, next) => {
  const { name, role, company, quote, featured } = req.body;
  try {
    const [result] = await pool.query(
      "UPDATE testimonials SET name=?, role=?, company=?, quote=?, featured=? WHERE id=?",
      [name, role, company, quote, featured ?? 0, req.params.id]
    );
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: "Testimonial not found" });
    res.json({ success: true, message: "Testimonial updated" });
  } catch (err) { next(err) }
};

const deleteTestimonial = async (req, res, next) => {
	try {
		const [result] = await pool.query("DELETE FROM testimonials WHERE id=?", [
			req.params.id,
		]);
		if (!result.affectedRows)
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
