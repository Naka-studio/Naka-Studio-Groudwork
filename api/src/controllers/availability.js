const pool = require("../config/db");

const getAvailability = async (req, res, next) => {
	try {
		const [rows] = await pool.query("SELECT * FROM availability WHERE id = 1");
		res.json({ success: true, data: rows[0] });
	} catch (err) {
		next(err);
	}
};

const updateAvailability = async (req, res, next) => {
	const { status } = req.body;
	const allowed = ["available", "limited", "unavailable"];
	if (!allowed.includes(status))
		return res.status(400).json({ success: false, message: "Invalid status" });
	try {
		await pool.query("UPDATE availability SET status=? WHERE id=1", [status]);
		res.json({ success: true, message: "Availability updated" });
	} catch (err) {
		next(err);
	}
};

module.exports = { getAvailability, updateAvailability };
