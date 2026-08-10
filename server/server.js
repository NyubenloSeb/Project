const express = require("express");
const mongoose = require("mongoose");

//forcing the dns (windows issue)
const dns = require("node:dns/promises");
dns.setServers(["1.1.1.1", "1.0.0.1"]);

require("dotenv").config();

const port = process.env.PORT;

//connect to the database
mongoose
  .connect(process.env.MONGO_URI, {})
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log("Error connecting to MongoDB: ", err);
  });

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//models
require("./models/Homes");

//routes
require("./routes/homesRoutes");

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
