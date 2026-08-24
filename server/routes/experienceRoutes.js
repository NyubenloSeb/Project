const mongoose = require("mongoose");
const Experience = mongoose.model("experience");

module.exports = (app) => {
  // GET REQUEST(using express ) || read Experience
  app.get("/api/v1/get/experience", async (req, res) => {
    console.log("GET Experience");

    try {
      const response = await Experience.find();
      res.status(201).json({ message: "Featured Experiences: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

  app.post("/api/v1/add/experience", async (req, res) => {
    console.log("ADDED A NEW Experience");

    const {
      name,
      location,
      description,
      images,
      rating,
      hostName,
      experienceDescription,
      price,
      perks,
      totalReviews,
    } = req.body;

    try {
      const experience = await Experience.findOne({ name }); //check if the experience already exists
      if (experience) {
        res.status(400).json({ message: "Experience already exist!" });
      }

      experienceFields = {
        name,
        location,
        description,
        images,
        rating,
        hostName,
        experienceDescription,
        totalReviews,
        price,
        perks,
      };

      const response = await Experience.create(experienceFields);

      res.status(201).json({ message: "Added a New Experience : ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
};
