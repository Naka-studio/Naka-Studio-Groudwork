const pool = require("../config/db");

const getProjects = async (req, res, next) => {
  try {
    const { rows } = await pool.query("SELECT * FROM projects ORDER BY id ASC");
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getFeaturedProjects = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM projects WHERE featured = true",
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getProjectById = async (req, res, next) => {
  try {
    const { rows } = await pool.query("SELECT * FROM projects WHERE id = $1", [
      req.params.id,
    ]);
    if (!rows.length)
      return res
        .status(404)
        .json({ success: false, message: "Project not found" });
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const createProject = async (req, res, next) => {
  const { title, category, description, tags, image, featured } = req.body;
  try {
    const { rows } = await pool.query(
      "INSERT INTO projects (title, category, description, tags, image, featured) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id",
      [title, category, description, tags, image, featured ?? false],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateProject = async (req, res, next) => {
  const { title, category, description, tags, image, featured } = req.body;
  try {
    const { rowCount } = await pool.query(
      "UPDATE projects SET title=$1, category=$2, description=$3, tags=$4, image=$5, featured=$6 WHERE id=$7",
      [
        title,
        category,
        description,
        tags,
        image,
        featured ?? false,
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
    const { rowCount } = await pool.query("DELETE FROM projects WHERE id=$1", [
      req.params.id,
    ]);
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
  getFeaturedProjects,
  getProjectById,
  createProject,
  updateProject,
  deleteProject,
};

