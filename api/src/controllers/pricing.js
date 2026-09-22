const pool = require("../config/db");

const getPricing = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM pricing ORDER BY sort_order ASC",
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getPricingById = async (req, res, next) => {
  try {
    const { rows } = await pool.query("SELECT * FROM pricing WHERE id = $1", [
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
    await pool.query(
      "INSERT INTO pricing (id, label, starting_from, currency, includes, sort_order) VALUES ($1, $2, $3, $4, $5, $6)",
      [id, label, starting_from, currency, includes, sort_order ?? 0],
    );
    res.status(201).json({ success: true, id });
  } catch (err) {
    next(err);
  }
};

const updatePricing = async (req, res, next) => {
  const { label, starting_from, currency, includes, sort_order } = req.body;
  try {
    const { rowCount } = await pool.query(
      "UPDATE pricing SET label=$1, starting_from=$2, currency=$3, includes=$4, sort_order=$5 WHERE id=$6",
      [
        label,
        starting_from,
        currency,
        includes,
        sort_order ?? 0,
        req.params.id,
      ],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Pricing not found" });
    res.json({ success: true, message: "Pricing updated" });
  } catch (err) {
    next(err);
  }
};

const deletePricing = async (req, res, next) => {
  try {
    const { rowCount } = await pool.query("DELETE FROM pricing WHERE id=$1", [
      req.params.id,
    ]);
    if (!rowCount)
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
