const pool = require("../config/db");

const getPricing = async (req, res, next) => {
	try {
		const [rows] = await pool.query(
			"SELECT * FROM pricing ORDER BY sort_order ASC",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const getPricingById = async (req, res, next) => {
	try {
		const [rows] = await pool.query("SELECT * FROM pricing WHERE id = ?", [
			req.params.id,
		]);
		if (!rows.length)
			return res
				.status(404)
				.json({ success: false, message: "Pricing not found" });
		res.json({ success: true, data: rows[0] });
	} catch (err) {
		next(err);
	}
};

const createPricing = async (req, res, next) => {
  const { id, label, starting_from, currency, includes, sort_order } = req.body;
  try {
    const [result] = await pool.query(
      "INSERT INTO pricing (id, label, starting_from, currency, includes, sort_order) VALUES (?, ?, ?, ?, ?, ?)",
      [id, JSON.stringify(label), starting_from, currency, JSON.stringify(includes), sort_order ?? 0]
    );
    res.status(201).json({ success: true, id: result.insertId });
  } catch (err) { next(err) }
};

const updatePricing = async (req, res, next) => {
  const { label, starting_from, currency, includes, sort_order } = req.body;
  try {
    const [result] = await pool.query(
      "UPDATE pricing SET label=?, starting_from=?, currency=?, includes=?, sort_order=? WHERE id=?",
      [JSON.stringify(label), starting_from, currency, JSON.stringify(includes), sort_order ?? 0, req.params.id]
    );
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: "Pricing not found" });
    res.json({ success: true, message: "Pricing updated" });
  } catch (err) { next(err) }
};

const deletePricing = async (req, res, next) => {
	try {
		const [result] = await pool.query("DELETE FROM pricing WHERE id=?", [
			req.params.id,
		]);
		if (!result.affectedRows)
			return res
				.status(404)
				.json({ success: false, message: "Pricing not found" });
		res.json({ success: true, message: "Pricing deleted" });
	} catch (err) {
		next(err);
	}
};

module.exports = {
	getPricing,
	getPricingById,
	createPricing,
	updatePricing,
	deletePricing,
};
