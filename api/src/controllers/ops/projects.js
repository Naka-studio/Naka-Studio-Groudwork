const pool = require("../../config/db");

const getProjects = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `SELECT p.*, c.name AS contact_name, c.wa AS contact_wa
       FROM ops.projects p
       LEFT JOIN ops.contacts c ON p.contact_id = c.id
       ORDER BY p.created_at DESC`,
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getProjectById = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `SELECT p.*, c.name AS contact_name, c.wa AS contact_wa
       FROM ops.projects p
       LEFT JOIN ops.contacts c ON p.contact_id = c.id
       WHERE p.id = $1`,
      [req.params.id],
    );
    if (!rows.length)
      return res
        .status(404)
        .json({ success: false, message: "Project not found" });
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const getActiveCapacity = async (req, res, next) => {
  try {
    const { rows } = await pool.query("SELECT * FROM ops.active_capacity");
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const createProject = async (req, res, next) => {
  const { contact_id, package: pkg, title, status, notes } = req.body;
  if (!contact_id || !pkg)
    return res
      .status(400)
      .json({ success: false, message: "contact_id dan package wajib diisi" });
  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.projects (contact_id, package, title, status, notes)
       VALUES ($1, $2, $3, $4, $5) RETURNING id`,
      [contact_id, pkg, title, status ?? "LEAD", notes],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateProjectStatus = async (req, res, next) => {
  const { status, capacity_slot, started_at, closed_at, notes } = req.body;
  try {
    const { rowCount } = await pool.query(
      `UPDATE ops.projects
       SET status=$1, capacity_slot=$2, started_at=$3, closed_at=$4, notes=$5
       WHERE id=$6`,
      [
        status,
        capacity_slot ?? false,
        started_at,
        closed_at,
        notes,
        req.params.id,
      ],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Project not found" });
    res.json({ success: true, message: "Project updated" });
  } catch (err) {
    next(err);
  }
};

const deleteProject = async (req, res, next) => {
  try {
    const { rowCount } = await pool.query(
      "DELETE FROM ops.projects WHERE id=$1",
      [req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Project not found" });
    res.json({ success: true, message: "Project deleted" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getProjects,
  getProjectById,
  getActiveCapacity,
  createProject,
  updateProjectStatus,
  deleteProject,
};
