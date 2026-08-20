const mongoose = require("mongoose");
const { Schema } = mongoose;

const homeSchema = new Schema({
  name: { type: String },
  location: { type: String },
  description: { type: String },
  images: { type: [String] },
  rating: { type: Number },
  hostName: { type: String },
  propertyDescription: { type: String },
  totalReviews: { type: Number },
  perks: { type: String },
});

mongoose.model("homes", homeSchema);
