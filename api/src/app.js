const express = require("express");
const cors = require("cors");

const blogRoutes = require("./routes/blog");
const projectsRoutes = require("./routes/projects");
const servicesRoutes = require("./routes/services");
const pricingRoutes = require("./routes/pricing");
const testimonialsRoutes = require("./routes/testimonials");
const availabilityRoutes = require("./routes/availability");
const contactRoutes = require("./routes/contact");
const authRoutes = require('./routes/auth')

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes)
app.use("/api/blog", blogRoutes);
app.use("/api/projects", projectsRoutes);
app.use("/api/services", servicesRoutes);
app.use("/api/pricing", pricingRoutes);
app.use("/api/testimonials", testimonialsRoutes);
app.use("/api/availability", availabilityRoutes);
app.use("/api/contact", contactRoutes);

app.get("/", (req, res) => {
  res.json({ message: "Naka Studio API is alive 🎯" });
});

module.exports = app;
