const express = require("express");
const mongoose = require("mongoose");
const Booking = require("../models/Booking");
const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();
const Home = mongoose.model("homes");

// Create a booking
router.post("/", authMiddleware, async (req, res) => {
  try {
    const { homeId, checkIn, checkOut, guests } = req.body;

    if (
      !mongoose.isValidObjectId(homeId) ||
      !checkIn ||
      !checkOut ||
      !Number.isInteger(guests) ||
      guests < 1
    ) {
      return res.status(400).json({ message: "Invalid booking details." });
    }

    const start = new Date(checkIn);
    const end = new Date(checkOut);

    if (
      isNaN(start.getTime()) ||
      isNaN(end.getTime()) ||
      start >= end ||
      start < new Date(new Date().toDateString())
    ) {
      return res.status(400).json({ message: "Invalid booking dates." });
    }

    const home = await Home.findById(homeId);

    if (!home) {
      return res.status(404).json({ message: "Home not found." });
    }

    // Check property availability
    const overlappingBooking = await Booking.findOne({
      listingType: "home",
      listingId: home._id,
      status: { $in: ["pending", "confirmed"] },
      checkIn: { $lt: end },
      checkOut: { $gt: start }
    });

    if (overlappingBooking) {
      return res.status(409).json({
        message: "This property is not available for the selected dates."
      });
    }

    // Calculate price
    const nights = Math.ceil(
      (end - start) / (1000 * 60 * 60 * 24)
    );
    const totalPrice = home.price * nights;

    const booking = await Booking.create({
  user: req.userId,
  home: home._id,
  listingType: "home",
  listingId: home._id,
  checkIn: start,
  checkOut: end,
  guests,
  totalPrice,
  status: "confirmed"
});

    res.status(201).json({
      message: "Booking created.",
      booking
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to create booking." });
  }
});

// Get logged-in user's bookings
router.get("/", authMiddleware, async (req, res) => {
  try {
    const bookings = await Booking.find({ user: req.userId })
      .populate("home", "name")
      .sort({ createdAt: -1 });

    res.json({ bookings });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to fetch bookings." });
  }
});
// Cancel a booking
router.patch("/:id/cancel", authMiddleware, async (req, res) => {
  try {
    const booking = await Booking.findOne({
      _id: req.params.id,
      user: req.userId,
    });

    if (!booking) {
      return res.status(404).json({
        message: "Booking not found.",
      });
    }

    if (booking.status === "cancelled") {
      return res.status(400).json({
        message: "Booking is already cancelled.",
      });
    }

    booking.status = "cancelled";
    await booking.save();

    return res.status(200).json({
      message: "Booking cancelled successfully.",
      booking,
    });
  } catch (error) {
    console.error("Cancellation error:", error);
    return res.status(500).json({
      message: "Failed to cancel booking.",
    });
  }
});

module.exports = router;
