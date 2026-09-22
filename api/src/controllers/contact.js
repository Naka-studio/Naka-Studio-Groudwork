const pool = require("../config/db");

const getContact = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM contact_info WHERE id = 1",
    );
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const submitContact = async (req, res, next) => {
  const { name, email, message } = req.body;
  if (!name || !email || !message)
    return res
      .status(400)
      .json({ success: false, message: "Semua field wajib diisi" });
  try {
    await pool.query(
      "INSERT INTO contact_messages (name, email, message) VALUES ($1, $2, $3)",
      [name, email, message],
    );
    res.status(201).json({ success: true, message: "Pesan berhasil dikirim" });
  } catch (err) {
    next(err);
  }
};

const updateContact = async (req, res, next) => {
  const { wa, email, instagram, youtube, linkedin, github, profile_web } =
    req.body;
  try {
    await pool.query(
      "UPDATE contact_info SET wa=$1, email=$2, instagram=$3, youtube=$4, linkedin=$5, github=$6, profile_web=$7 WHERE id=1",
      [wa, email, instagram, youtube, linkedin, github, profile_web],
    );
    res.json({ success: true, message: "Contact updated" });
  } catch (err) {
    next(err);
  }
};

const getMessages = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      "SELECT * FROM contact_messages ORDER BY created_at DESC",
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const deleteMessage = async (req, res, next) => {
  try {
    const { rowCount } = await pool.query(
      "DELETE FROM contact_messages WHERE id=$1",
      [req.params.id],
    );
    if (!rowCount)
      return res
        .status(404)
        .json({ success: false, message: "Message not found" });
    res.json({ success: true, message: "Message deleted" });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getContact,
  submitContact,
  updateContact,
  getMessages,
  deleteMessage,
};
