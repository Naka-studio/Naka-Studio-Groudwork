const pool = require("../../config/db");

const getContacts = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.contacts ORDER BY created_at DESC"
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getContactById = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM ops.contacts WHERE id = $1",
      [req.params.id]
    );
    if (!rows.length)
      return res.status(404).json({ success: false, message: "Contact not found" });
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const createContact = async (req, res, next) => {
  const { name, wa, email, source, status, notes } = req.body;
  if (!name)
    return res.status(400).json({ success: false, message: "Name wajib diisi" });
  try {
    const { rows } = await pool.query(
      `INSERT INTO ops.contacts (name, wa, email, source, status, notes)
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING id`,
      [name, wa, email, source, status ?? "lead", notes]
    );
    res.status(201).json({ success: true, id: rows[0].id });
  } catch (err) {
    next(err);
  }
};

const updateContact = async (req, res, next) => {
  const { name, wa, email, source, status, notes } = req.body;
  try {
    const { rowCount } = await pool.query(
      `UPDATE ops.contacts SET name=$1, wa=$2, email=$3, source=$4, status=$5, notes=$6
       WHERE id=$7`,
      [name, wa, email, source, status, notes, req.params.id]
    );
    if (!rowCount)
      return res.status(404).json({ success: false, message: "Contact not found" });
    res.json({ success: true, message: "Contact updated" });
  } catch (err) {
    next(err);
  }
};

const deleteContact = async (req, res, next) => {
  try {
    const { rowCount } = await pool.query(
      "DELETE FROM ops.contacts WHERE id=$1",
      [req.params.id]
    );
    if (!rowCount)
      return res.status(404).json({ success: false, message: "Contact not found" });
    res.json({ success: true, message: "Contact deleted" });
  } catch (err) {
    next(err);
  }
};

module.exports = { getContacts, getContactById, createContact, updateContact, deleteContact };
