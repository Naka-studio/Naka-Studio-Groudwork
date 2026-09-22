const pool = require("../config/db");

const getPosts = async (req, res, next) => {
	try {
		const { rows } = await pool.query(
			"SELECT * FROM blog_posts ORDER BY date DESC",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const getFeaturedPosts = async (req, res, next) => {
	try {
		const { rows } = await pool.query(
			"SELECT * FROM blog_posts WHERE featured = true ORDER BY date DESC",
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const getPostBySlug = async (req, res, next) => {
	try {
		const { rows } = await pool.query(
			"SELECT * FROM blog_posts WHERE slug = $1",
			[req.params.slug],
		);
		if (!rows.length)
			return res
				.status(404)
				.json({ success: false, message: "Post not found" });
		res.json({ success: true, data: rows[0] });
	} catch (err) {
		next(err);
	}
};

const getPostsByCategory = async (req, res, next) => {
	try {
		const { rows } = await pool.query(
			"SELECT * FROM blog_posts WHERE category = $1 ORDER BY date DESC",
			[req.params.category],
		);
		res.json({ success: true, data: rows });
	} catch (err) {
		next(err);
	}
};

const createPost = async (req, res, next) => {
	const {
		title,
		excerpt,
		slug,
		category,
		content_en,
		content_id,
		read_time,
		date,
		featured,
		status,
	} = req.body;
	try {
		const { rows } = await pool.query(
			`INSERT INTO blog_posts (title, excerpt, slug, category, content_en, content_id, read_time, date, featured, status)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id`,
			[
				title,
				excerpt,
				slug,
				category,
				content_en,
				content_id,
				read_time,
				date,
				featured ?? false,
				status ?? "published",
			],
		);
		res.status(201).json({ success: true, id: rows[0].id });
	} catch (err) {
		next(err);
	}
};

const updatePost = async (req, res, next) => {
	const {
		title,
		excerpt,
		slug,
		category,
		content_en,
		content_id,
		read_time,
		date,
		featured,
		status,
	} = req.body;
	try {
		const { rowCount } = await pool.query(
			`UPDATE blog_posts SET title=$1, excerpt=$2, slug=$3, category=$4,
       content_en=$5, content_id=$6, read_time=$7, date=$8, featured=$9, status=$10 WHERE id=$11`,
			[
				title,
				excerpt,
				slug,
				category,
				content_en,
				content_id,
				read_time,
				date,
				featured ?? false,
				status ?? "published",
				req.params.id,
			],
		);
		if (!rowCount)
			return res
				.status(404)
				.json({ success: false, message: "Post not found" });
		res.json({ success: true, message: "Post updated" });
	} catch (err) {
		next(err);
	}
};

const deletePost = async (req, res, next) => {
	try {
		const { rowCount } = await pool.query(
			"DELETE FROM blog_posts WHERE id=$1",
			[req.params.id],
		);
		if (!rowCount)
			return res
				.status(404)
				.json({ success: false, message: "Post not found" });
		res.json({ success: true, message: "Post deleted" });
	} catch (err) {
		next(err);
	}
};

module.exports = {
	getPosts,
	getFeaturedPosts,
	getPostBySlug,
	getPostsByCategory,
	createPost,
	updatePost,
	deletePost,
};
