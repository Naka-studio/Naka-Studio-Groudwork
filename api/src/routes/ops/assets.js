const express = require("express");
const router = express.Router();
const verifyToken = require("../../middleware/auth");
const c = require("../../controllers/ops/assets");

router.get("/project/:project_id", verifyToken, c.getAssetCollection);
router.post("/", verifyToken, c.createAssetCollection);
router.patch("/:id/status", verifyToken, c.updateAssetCollectionStatus);
router.post("/items", verifyToken, c.addAssetItem);
router.patch("/items/:id/status", verifyToken, c.updateAssetItemStatus);

module.exports = router;
