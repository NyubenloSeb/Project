const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      required: true,
      unique: true,
      lowercase: true,
    },
    passwordHash: {
      type: String,
      required: true,
      select: false,
    },
    role: {
      type: String,
      enum: ["user"],
      default: "user",
    },
    wishlist: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "homes",
      },
    ],
  },
  { timestamps: true },
);

module.exports = mongoose.models.users || mongoose.model("users", userSchema);
