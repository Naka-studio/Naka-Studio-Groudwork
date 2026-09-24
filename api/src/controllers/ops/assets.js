const pool = require("../../config/db");

const getAssetCollection = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.asset_collections WHERE project_id = $1",
      [req.params.project_id],
    );
    if (!rows.length)
      return res
        .status(404)
        .json({ success: false, message: "Asset collection not found" });

    const { rows: items } = await pool.query(
      "SELECT * FROM ops.asset_items WHERE collection_id = $1 ORDER BY id ASC",
      [rows[0].id],
    );
    res.json({ success: true, data: { ...rows[0], items } });
  } catch (err) {
    next(err);
  }
};

const createAssetCollection = async (req, res, next) => {
  const { project_id, deadline, notes } = req.body;
  if (!project_id)
    return res
      .status(400)
      .json({ success: false, message: "project_id wajib diisi" });
  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.asset_collections (project_id, deadline, notes)
       VALUES ($1, $2, $3) RETURNING id`,
      [project_id, deadline, notes],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateAssetCollectionStatus = async (req, res, next) => {
  const { status, confirmed_complete_at, notes } = req.body;
  const allowed = ["pending", "incomplete", "complete"];
  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: "Invalid status" });
  try {
    const { rowCount } = await pool.query(
      "UPDATE ops.asset_collections SET status=$1, confirmed_complete_at=$2, notes=$3 WHERE id=$4",
      [status, confirmed_complete_at, notes, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Collection not found" });
    res.json({ success: true, message: "Asset collection updated" });
  } catch (err) {
    next(err);
  }
};

const addAssetItem = async (req, res, next) => {
  const { collection_id, name, notes } = req.body;
  if (!collection_id || !name)
    return res
      .status(400)
      .json({ success: false, message: "collection_id dan name wajib diisi" });
  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.asset_items (collection_id, name, notes)
       VALUES ($1, $2, $3) RETURNING id`,
      [collection_id, name, notes],
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateAssetItemStatus = async (req, res, next) => {
  const { status, notes, received_at } = req.body;
  const allowed = ["missing", "received", "rejected"];
  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: "Invalid status" });
  try {
    const { rowCount } = await pool.query(
      "UPDATE ops.asset_items SET status=$1, notes=$2, received_at=$3 WHERE id=$4",
      [status, notes, received_at, req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Asset item not found" });
    res.json({ success: true, message: "Asset item updated" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getAssetCollection,
  createAssetCollection,
  updateAssetCollectionStatus,
  addAssetItem,
  updateAssetItemStatus,
};
