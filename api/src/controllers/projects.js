const pool = require("../config/db");

const getProjects = async (req, res, next) => {
  try {
    const [rows] = await pool.query("SELECT * FROM projects ORDER BY id ASC");
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getFeaturedProjects = async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      "SELECT * FROM projects WHERE featured = 1"
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getProjectById = async (req, res, next) => {
  try {
    const [rows] = await pool.query("SELECT * FROM projects WHERE id = ?", [
      req.params.id,
    ]);
    if (!rows.length)
      return res.status(404).json({ success: false, message: "Project not found" });
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const createProject = async (req, res, next) => {
  const { title, category, description, tags, image, featured } = req.body;
  try {
    const [result] = await pool.query(
      "INSERT INTO projects (title, category, description, tags, image, featured) VALUES (?, ?, ?, ?, ?, ?)",
      [title, category, description, JSON.stringify(tags), image, featured ?? 0]
    );
    res.status(201).json({ success: true, id: result.insertId });
  } catch (err) {
    next(err);
  }
};

const updateProject = async (req, res, next) => {
  const { title, category, description, tags, image, featured } = req.body;
  try {
    const [result] = await pool.query(
      "UPDATE projects SET title=?, category=?, description=?, tags=?, image=?, featured=? WHERE id=?",
      [title, category, description, JSON.stringify(tags), image, featured ?? 0, req.params.id]
    );
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: "Project not found" });
    res.json({ success: true, message: "Project updated" });
  } catch (err) {
    next(err);
  }
};

const deleteProject = async (req, res, next) => {
  try {
    const [result] = await pool.query("DELETE FROM projects WHERE id=?", [
      req.params.id,
    ]);
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: "Project not found" });
    res.json({ success: true, message: "Project deleted" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getProjects,
  getFeaturedProjects,
  getProjectById,
  createProject,
  updateProject,
  deleteProject,
};