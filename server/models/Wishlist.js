
const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "users",
    required: true
  },
  listingType: {
    type: String,
    enum: ["home", "experience", "service"],
    required: true
  },
  listingId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true
  },
  checkIn: Date,
  checkOut: Date,
  bookingDate: Date,
  guests: {
    type: Number,
    required: true,
    min: 1
  },
  totalPrice: {
    type: Number,
    required: true,
    min: 0
  },
  status: {
    type: String,
    enum: ["pending", "confirmed", "cancelled"],
    default: "pending"
  }
}, { timestamps: true });

module.exports = mongoose.model("Booking", bookingSchema);
