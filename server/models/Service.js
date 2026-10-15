const mongoose = require("mongoose");
const { Schema } = mongoose;

const serviceSchema = new Schema({
  name: { type: String },
  location: { type: String },
  images: { type: [String] },
  rating: { type: Number },
  serviceName: { type: String },
  serviceDescription: { type: String },
  totalReviews: { type: Number },
  price: { type: Number },
});

mongoose.model("service", serviceSchema);
