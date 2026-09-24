const pool = require("../../config/db");

const getRevisionsByProject = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.revisions WHERE project_id = $1 ORDER BY round_number ASC",
      [req.params.project_id],
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const createRevision = async (req, res, next) => {
  const { project_id, round_number, feedback_batch, deadline } = req.body;

  if (!project_id || !round_number)
    return res
      .status(400)
      .json({
        success: false,
        message: "project_id dan round_number wajib diisi",
      });

  if (round_number > 3)
    return res
      .status(400)
      .json({ success: false, message: "Maksimal 3 revision rounds" });

  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.revisions (project_id, round_number, feedback_batch, submitted_at, deadline)
       VALUES ($1, $2, $3, NOW(), $4) RETURNING id`,
      [project_id, round_number, feedback_batch, deadline],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateRevisionStatus = async (req, res, next) => {
  const { status, completed_at, notes } = req.body;
  const allowed = [
    "pending",
    "submitted",
    "in_progress",
    "done",
    "admin_accepted",
  ];
  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: "Invalid status" });
  try {
    const { rowCount } = await pool.query(
      "UPDATE ops.revisions SET status=$1, completed_at=$2, notes=$3 WHERE id=$4",
      [status, completed_at, notes, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Revision not found" });
    res.json({ success: true, message: "Revision updated" });
  } catch (err) {
    next(err);
  }
};

// Scope changes
const getScopeChangesByProject = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.scope_changes WHERE project_id = $1 ORDER BY created_at DESC",
      [req.params.project_id],
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const createScopeChange = async (req, res, next) => {
  const { project_id, revision_id, description, notes } = req.body;
  if (!project_id || !description)
    return res
      .status(400)
      .json({
        success: false,
        message: "project_id dan description wajib diisi",
      });
  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.scope_changes (project_id, revision_id, description, notes)
       VALUES ($1, $2, $3, $4) RETURNING id`,
      [project_id, revision_id, description, notes],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateScopeChangeStatus = async (req, res, next) => {
  const { status, additional_quotation_id, notes } = req.body;
  const allowed = ["pending", "quoted", "approved", "rejected", "done"];
  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: "Invalid status" });
  try {
    const { rowCount } = await pool.query(
      "UPDATE ops.scope_changes SET status=$1, additional_quotation_id=$2, notes=$3 WHERE id=$4",
      [status, additional_quotation_id, notes, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Scope change not found" });
    res.json({ success: true, message: "Scope change updated" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getRevisionsByProject,
  createRevision,
  updateRevisionStatus,
  getScopeChangesByProject,
  createScopeChange,
  updateScopeChangeStatus,
};
