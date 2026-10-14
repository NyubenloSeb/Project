
const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/Users");

const router = express.Router();

// Register
router.post("/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password || password.length < 8)
      return res.status(400).json({
        message: "Provide name, email, and password (minimum 8 characters).",
      });

    const normalizedEmail = email.trim().toLowerCase();

    if (await User.findOne({ email: normalizedEmail }))
      return res.status(409).json({ message: "Email already registered." });

    const user = await User.create({
      name,
      email: normalizedEmail,
      passwordHash: await bcrypt.hash(password, 12),
    });

    res.status(201).json({
      message: "Registration successful.",
      user: { id: user._id, name: user.name, email: user.email },
    });
  } catch (error) {
    if (error.code === 11000)
      return res.status(409).json({ message: "Email already registered." });

    res.status(500).json({ message: "Registration failed." });
  }
});

// Login
router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password)
      return res.status(400).json({ message: "Email and password required." });

    const user = await User.findOne({
      email: email.trim().toLowerCase(),
    }).select("+passwordHash");

    if (!user || !(await bcrypt.compare(password, user.passwordHash)))
      return res.status(401).json({ message: "Invalid email or password." });

    const token = jwt.sign(
      { userId: user._id },
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    res.json({
      message: "Login successful.",
      token,
      user: { id: user._id, name: user.name, email: user.email },
    });
  } catch (error) {
    res.status(500).json({ message: "Login failed." });
  }
});

module.exports = router;
