const express = require("express");
const router = express.Router();
const verifyToken = require("../middleware/auth");
const { getServices, getServiceById, updateService } = require("../controllers/services");

router.get("/", getServices);
router.get("/:id", getServiceById);

router.put("/:id", verifyToken, updateService);

module.exports = router;