const pool = require("../../config/db");

const getPayments = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `SELECT pay.*, p.title AS project_title
       FROM ops.payments pay
       LEFT JOIN ops.projects p ON pay.project_id = p.id
       ORDER BY pay.created_at DESC`,
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getPaymentsByProject = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.payments WHERE project_id = $1 ORDER BY created_at DESC",
      [req.params.project_id],
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const createPayment = async (req, res, next) => {
  const {
    project_id,
    quotation_id,
    type,
    amount,
    currency,
    method,
    invoice_number,
    invoice_sent_at,
    due_date,
    notes,
  } = req.body;

  if (!project_id || !type || !amount)
    return res
      .status(400)
      .json({
        success: false,
        message: "project_id, type, amount wajib diisi",
      });

  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.payments (
        project_id, quotation_id, type, amount, currency,
        method, invoice_number, invoice_sent_at, due_date, notes
       ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING id`,
      [
        project_id,
        quotation_id,
        type,
        amount,
        currency ?? "IDR",
        method,
        invoice_number,
        invoice_sent_at,
        due_date,
        notes,
      ],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updatePaymentStatus = async (req, res, next) => {
  const { status, paid_at, method } = req.body;
  const allowed = ["unpaid", "paid", "overdue", "cancelled"];
  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: "Invalid status" });
  try {
    const { rowCount } = await pool.query(
      "UPDATE ops.payments SET status=$1, paid_at=$2, method=$3 WHERE id=$4",
      [status, paid_at, method, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Payment not found" });
    res.json({ success: true, message: "Payment status updated" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getPayments,
  getPaymentsByProject,
  createPayment,
  updatePaymentStatus,
};
