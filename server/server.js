const express = require("express");
const mongoose = require("mongoose");

// DNS configuration
const dns = require("node:dns/promises");
dns.setServers(["1.1.1.1", "1.0.0.1"]);

require("dotenv").config();

const port = process.env.PORT || 5001;

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("Connected to MongoDB"))
  .catch((err) => console.log("MongoDB error:", err.message));

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Models
require("./models/Homes");
require("./models/Experience");
require("./models/Users");
require("./models/Service");

// Routes
require("./routes/homeRoutes")(app);
require("./routes/experienceRoutes")(app);
require("./routes/serviceRoutes")(app);
app.use("/api/auth", require("./routes/authRoutes"));

app.listen(port, "0.0.0.0", () => {
  console.log(`Server is running on port ${port}`);
});
