const mongoose = require("mongoose");

const wishlistSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "users",
    required: true
  },
  home: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Homes",
    required: true
  }
}, { timestamps: true });

wishlistSchema.index({ user: 1, home: 1 }, { unique: true });

module.exports = mongoose.model("Wishlist", wishlistSchema);