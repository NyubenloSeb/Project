const mongoose = require("mongoose");
const Home = mongoose.model("homes");

module.exports = (app) => {
  // GET REQUEST(using express ) || read Homes
  app.get("/api/v1/get/home", async (req, res) => {
    console.log("GET HOMES");

    try {
      const response = await Home.find();
      res.status(201).json({ message: "Featured Homes: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

  app.post("/api/v1/add/home", async (req, res) => {
    console.log("ADDED A NEW HOME");

    const {
      name,
      location,
      description,
      images,
      rating,
      hostName,
      propertyDescription,
      price,
      perks,
      totalReviews,
    } = req.body;

    try {
      const home = await Home.findOne({ name }); //check if the home already exists
      if (home) {
        res.status(400).json({ message: "Home already exist!" });
      }

      homeFields = {
        name,
        location,
        description,
        images,
        rating,
        hostName,
        propertyDescription,
        totalReviews,
        price,
        perks,
      };

      const response = await Home.create(homeFields);

      res.status(201).json({ message: "Added a New Home : ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
};
