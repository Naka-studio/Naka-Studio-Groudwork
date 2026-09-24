const pool = require("../../config/db");

const getQuotations = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `SELECT q.*, p.title AS project_title, p.status AS project_status
       FROM ops.quotations q
       LEFT JOIN ops.projects p ON q.project_id = p.id
       ORDER BY q.created_at DESC`,
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getQuotationById = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.quotations WHERE id = $1",
      [req.params.id],
    );
    if (!rows.length)
      return res
        .status(404)
        .json({ success: false, message: "Quotation not found" });
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const getQuotationsByProject = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.quotations WHERE project_id = $1 ORDER BY created_at DESC",
      [req.params.project_id],
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const createQuotation = async (req, res, next) => {
  const {
    project_id,
    quotation_number,
    package: pkg,
    add_ons,
    scope_notes,
    exclusions,
    complexity_notes,
    base_price,
    addons_price,
    total_price,
    currency,
    revision_limit,
    dp_percentage,
    final_percentage,
    estimated_duration,
    estimated_start,
    estimated_delivery,
    milestones,
    valid_until,
    notes,
  } = req.body;

  if (!project_id || !quotation_number || !base_price || !total_price)
    return res
      .status(400)
      .json({
        success: false,
        message:
          "project_id, quotation_number, base_price, total_price wajib diisi",
      });

  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.quotations (
        project_id, quotation_number, package, add_ons, scope_notes, exclusions,
        complexity_notes, base_price, addons_price, total_price, currency,
        revision_limit, dp_percentage, final_percentage, estimated_duration,
        estimated_start, estimated_delivery, milestones, valid_until, notes
       ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20)
       RETURNING id`,
      [
        project_id,
        quotation_number,
        pkg,
        add_ons,
        scope_notes,
        exclusions,
        complexity_notes,
        base_price,
        addons_price ?? 0,
        total_price,
        currency ?? "IDR",
        revision_limit ?? 3,
        dp_percentage ?? 50,
        final_percentage ?? 50,
        estimated_duration,
        estimated_start,
        estimated_delivery,
        milestones,
        valid_until,
        notes,
      ],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateQuotationStatus = async (req, res, next) => {
  const { status, approved_at } = req.body;
  const allowed = ["draft", "sent", "approved", "expired"];
  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: "Invalid status" });
  try {
    const { rowCount } = await pool.query(
      "UPDATE ops.quotations SET status=$1, approved_at=$2 WHERE id=$3",
      [status, approved_at, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Quotation not found" });
    res.json({ success: true, message: "Quotation status updated" });
  } catch (err) {
    next(err);
  }
};

const deleteQuotation = async (req, res, next) => {
  try {
    const { rowCount } = await pool.query(
      "DELETE FROM ops.quotations WHERE id=$1",
      [req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Quotation not found" });
    res.json({ success: true, message: "Quotation deleted" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getQuotations,
  getQuotationById,
  getQuotationsByProject,
  createQuotation,
  updateQuotationStatus,
  deleteQuotation,
};
