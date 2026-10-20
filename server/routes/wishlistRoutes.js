const express = require("express");
const mongoose = require("mongoose");
const User = require("../models/Users");
const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();
const Home = mongoose.model("homes");

// Get the logged-in user's wishlist
router.get("/", authMiddleware, async (req, res) => {
  try {
    const user = await User.findById(req.userId).populate("wishlist");

    if (!user) {
      return res.status(404).json({ message: "User not found." });
    }

    res.json({ wishlist: user.wishlist });
  } catch (error) {
    res.status(500).json({ message: "Failed to fetch wishlist." });
  }
});

// Add a home
router.post("/:homeId", authMiddleware, async (req, res) => {
  try {
    const { homeId } = req.params;

    if (!mongoose.isValidObjectId(homeId)) {
      return res.status(400).json({ message: "Invalid home ID." });
    }

    const homeExists = await Home.exists({ _id: homeId });

    if (!homeExists) {
      return res.status(404).json({ message: "Home not found." });
    }

    const user = await User.findByIdAndUpdate(
      req.userId,
      { $addToSet: { wishlist: homeId } },
      { new: true },
    ).populate("wishlist");

    if (!user) {
      return res.status(404).json({ message: "User not found." });
    }

    res.json({
      message: "Home added to wishlist.",
      wishlist: user.wishlist,
    });
  } catch (error) {
    res.status(500).json({ message: "Failed to update wishlist." });
  }
});

// Remove a home
router.delete("/:homeId", authMiddleware, async (req, res) => {
  try {
    const { homeId } = req.params;

    if (!mongoose.isValidObjectId(homeId)) {
      return res.status(400).json({ message: "Invalid home ID." });
    }

    const user = await User.findByIdAndUpdate(
      req.userId,
      { $pull: { wishlist: homeId } },
      { new: true },
    ).populate("wishlist");

    if (!user) {
      return res.status(404).json({ message: "User not found." });
    }

    res.json({
      message: "Home removed from wishlist.",
      wishlist: user.wishlist,
    });
  } catch (error) {
    res.status(500).json({ message: "Failed to update wishlist." });
  }
});

module.exports = router;
