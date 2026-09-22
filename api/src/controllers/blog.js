const pool = require("../config/db");

const getPosts = async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      "SELECT * FROM blog_posts ORDER BY date DESC"
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getFeaturedPosts = async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      "SELECT * FROM blog_posts WHERE featured = 1 ORDER BY date DESC"
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const getPostBySlug = async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      "SELECT * FROM blog_posts WHERE slug = ?",
      [req.params.slug]
    );
    if (!rows.length)
      return res.status(404).json({ success: false, message: "Post not found" });
    res.json({ success: true, data: rows[0] });
  } catch (err) {
    next(err);
  }
};

const getPostsByCategory = async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      "SELECT * FROM blog_posts WHERE category = ? ORDER BY date DESC",
      [req.params.category]
    );
    res.json({ success: true, data: rows });
  } catch (err) {
    next(err);
  }
};

const createPost = async (req, res, next) => {
  const { title, excerpt, slug, category, content_en, content_id, read_time, date, featured } = req.body
  try {
    const [result] = await pool.query(
      `INSERT INTO blog_posts (title, excerpt, slug, category, content_en, content_id, read_time, date, featured)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [JSON.stringify(title), JSON.stringify(excerpt), slug, category, content_en, content_id, read_time, date, featured ?? 0]
    )
    res.status(201).json({ success: true, id: result.insertId })
  } catch (err) {
    next(err)
  }
}

const updatePost = async (req, res, next) => {
  const { title, excerpt, slug, category, content_en, content_id, read_time, date, featured } = req.body
  try {
    const [result] = await pool.query(
      `UPDATE blog_posts SET
        title=?, excerpt=?, slug=?, category=?,
        content_en=?, content_id=?, read_time=?, date=?, featured=?
       WHERE id=?`,
      [JSON.stringify(title), JSON.stringify(excerpt), slug, category, content_en, content_id, read_time, date, featured ?? 0, req.params.id]
    )
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: 'Post not found' })
    res.json({ success: true, message: 'Post updated' })
  } catch (err) {
    next(err)
  }
}

const deletePost = async (req, res, next) => {
  try {
    const [result] = await pool.query("DELETE FROM blog_posts WHERE id=?", [
      req.params.id,
    ]);
    if (!result.affectedRows)
      return res.status(404).json({ success: false, message: "Post not found" });
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