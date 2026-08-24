const mongoose = require("mongoose");
const { Schema } = mongoose;
const experinceSchema = new Schema({
  name: { type: String },
  location: { type: String },
  description: { type: String },
  images: { type: [String] },
  rating: { type: Number },
  hostName: { type: String },
  experienceDescription: { type: String },
  totalReviews: { type: Number },
  perks: { type: String },
  price: { type: Number },
});

mongoose.model("experience", experinceSchema);
