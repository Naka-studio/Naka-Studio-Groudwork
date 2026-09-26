const pool = require("../config/db");

const getServices = async (req, res, next) => {
  try {
    const { rows } = await pool.query(`
      SELECT
        s.*,
        a.status AS availability_status,
        a.message AS availability_message,
        a.updated_at AS availability_updated_at
      FROM services s
      LEFT JOIN availability a
        ON a.service_id = s.id
      ORDER BY s.sort_order ASC
    `);

    res.json({
      success: true,
      data: rows,
    });
  } catch (err) {
    next(err);
  }
};

const getServiceById = async (req, res, next) => {
  try {
    const { rows } = await pool.query(
      `
        SELECT
          s.*,
          a.status AS availability_status,
          a.message AS availability_message,
          a.updated_at AS availability_updated_at
        FROM services s
        LEFT JOIN availability a
          ON a.service_id = s.id
        WHERE s.id = $1
      `,
      [req.params.id],
    );

    if (!rows.length) {
      return res
        .status(404)
        .json({
          success: false,
          message: "Service not found",
        });
    }

    res.json({
      success: true,
      data: rows[0],
    });
  } catch (err) {
    next(err);
  }
};

const updateService = async (req, res, next) => {
  const {
    title,
    tagline,
    description_en,
    description_id,
    tags,
    sort_order,
  } = req.body;

  try {
    const { rowCount } = await pool.query(
      `
        UPDATE services
        SET
          title = $1,
          tagline = $2,
          description_en = $3,
          description_id = $4,
          tags = $5,
          sort_order = $6
        WHERE id = $7
      `,
      [
        title,
        tagline,
        description_en,
        description_id,
        tags,
        sort_order ?? 0,
        req.params.id,
      ],
    );

    if (!rowCount) {
      return res
        .status(404)
        .json({
          success: false,
          message: "Service not found",
        });
    }

    res.json({
      success: true,
      message: "Service updated",
    });
  } catch (err) {
    next(err);
  }
};

const updateAvailability = async (req, res, next) => {
  const { status, message } = req.body
  const allowed = ['available', 'limited', 'unavailable']

  if (!allowed.includes(status))
    return res.status(400).json({ success: false, message: 'Invalid status' })

  try {
    const { rowCount } = await pool.query(
      `INSERT INTO availability (service_id, status, message)
       VALUES ($1, $2, $3)
       ON CONFLICT (service_id)
       DO UPDATE SET status = $2, message = $3, updated_at = CURRENT_TIMESTAMP`,
      [req.params.id, status, message ?? null]
    )

    res.json({ success: true, message: 'Availability updated' })
  } catch (err) {
    next(err)
  }
};

module.exports = {
  getServices,
  getServiceById,
  updateService,
	updateAvailability,
};