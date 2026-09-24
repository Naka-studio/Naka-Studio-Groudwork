const express = require("express");
const cors = require("cors");

// Public routes
const authRoutes = require("./routes/auth");
const blogRoutes = require("./routes/blog");
const projectsRoutes = require("./routes/projects");
const servicesRoutes = require("./routes/services");
const pricingRoutes = require("./routes/pricing");
const testimonialsRoutes = require("./routes/testimonials");
const availabilityRoutes = require("./routes/availability");
const contactRoutes = require("./routes/contact");

// Ops routes
const opsContactsRoutes = require("./routes/ops/contacts");
const opsProjectsRoutes = require("./routes/ops/projects");
const opsQuotationsRoutes = require("./routes/ops/quotations");
const opsPaymentsRoutes = require("./routes/ops/payments");
const opsRevisionsRoutes = require("./routes/ops/revisions");
const opsAssetsRoutes = require("./routes/ops/assets");
const opsActivityRoutes = require("./routes/ops/activity");

const app = express();

app.use(cors());
app.use(express.json());

// Public
app.use("/api/auth", authRoutes);
app.use("/api/blog", blogRoutes);
app.use("/api/projects", projectsRoutes);
app.use("/api/services", servicesRoutes);
app.use("/api/pricing", pricingRoutes);
app.use("/api/testimonials", testimonialsRoutes);
app.use("/api/availability", availabilityRoutes);
app.use("/api/contact", contactRoutes);

// Ops (semua protected via verifyToken di masing-masing route)
app.use("/api/ops/contacts", opsContactsRoutes);
app.use("/api/ops/projects", opsProjectsRoutes);
app.use("/api/ops/quotations", opsQuotationsRoutes);
app.use("/api/ops/payments", opsPaymentsRoutes);
app.use("/api/ops/revisions", opsRevisionsRoutes);
app.use("/api/ops/assets", opsAssetsRoutes);
app.use("/api/ops/activity", opsActivityRoutes);

app.get("/", (req, res) => {
  res.json({ message: "Naka Studio API is alive 🎯" });
});

module.exports = app;
