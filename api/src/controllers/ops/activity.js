const pool = require("../../config/db");

const getActivityByProject = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.activity_log WHERE project_id = $1 ORDER BY created_at DESC",
      [req.params.project_id],
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const logActivity = async (req, res, next) => {
  const {
    project_id,
    contact_id,
    type,
    description,
    actor,
    channel,
    metadata,
  } = req.body;
  if (!type || !description)
    return res
      .status(400)
      .json({ success: false, message: "type dan description wajib diisi" });
  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.activity_log (project_id, contact_id, type, description, actor, channel, metadata)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id`,
      [
        project_id,
        contact_id,
        type,
        description,
        actor ?? "naka",
        channel,
        metadata,
      ],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

module.exports = { getActivityByProject, logActivity };
