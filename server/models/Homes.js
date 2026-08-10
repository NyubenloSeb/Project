const mongoose = require("mongoose");
const { Schema } = mongoose;

const homeSchema = new Schema({
  name: { type: String },
  location: { type: String },
  images: { type: [String] },
  rating: { type: Number },
});

mongoose.model("homes", homeSchema);
