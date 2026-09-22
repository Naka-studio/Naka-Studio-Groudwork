const pool = require("../config/db");

const getServices = async (req, res, next) => {
	try {
		const [rows] = await pool.query(
			"SELECT * FROM services ORDER BY sort_order ASC",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const getServiceById = async (req, res, next) => {
	try {
		const [rows] = await pool.query("SELECT * FROM services WHERE id = ?", [
			req.params.id,
		]);
		if (!rows.length)
			return res
				.status(404)
				.json({ success: false, message: "Service not found" });
		res.json({ success: true, data: rows[0] });
	} catch (err) {
		next(err);
	}
};

const updateService = async (req, res, next) => {
  const { title, tagline, description_en, description_id, tags, sort_order } = req.body;
  try {
    const [result] = await pool.query(
      "UPDATE services SET title=?, tagline=?, description_en=?, description_id=?, tags=?, sort_order=? WHERE id=?",
      [title, tagline, description_en, description_id, JSON.stringify(tags), sort_order ?? 0, req.params.id]
    );
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: "Service not found" });
    res.json({ success: true, message: "Service updated" });
  } catch (err) { next(err) }
};

module.exports = { getServices, getServiceById, updateService };
