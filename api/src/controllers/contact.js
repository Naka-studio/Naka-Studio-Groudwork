const pool = require("../config/db");

const getContact = async (req, res, next) => {
	try {
		const [rows] = await pool.query("SELECT * FROM contact_info WHERE id = 1");
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
			"INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)",
			[name, email, message],
		);
		res.status(201).json({ success: true, message: "Pesan berhasil dikirim" });
	} catch (err) {
		next(err);
	}
};

const updateContact = async (req, res, next) => {
	const { whatsapp, email, instagram, github } = req.body;
	try {
		await pool.query(
			"UPDATE contact_info SET whatsapp=?, email=?, instagram=?, github=? WHERE id=1",
			[whatsapp, email, instagram, github],
		);
		res.json({ success: true, message: "Contact updated" });
	} catch (err) {
		next(err);
	}
};

const getMessages = async (req, res, next) => {
	try {
		const [rows] = await pool.query(
			"SELECT * FROM contact_messages ORDER BY created_at DESC",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const deleteMessage = async (req, res, next) => {
	try {
		const [result] = await pool.query(
			"DELETE FROM contact_messages WHERE id=?",
			[req.params.id],
		);
		if (!result.affectedRows)
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
