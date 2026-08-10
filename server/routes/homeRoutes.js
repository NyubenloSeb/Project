const mongoose = require("moongoose");
const Home = moongoose.model("homes");

module.exports = (app) => {
  // GET REQUEST(using express ) || read Homes
  app.get("/api/v1/get/homes", async (req, res) => {
    console.log("GET HOMES");

    try {
      const response = await Home.find();
      res.status(201).json({ message: "Features Homes: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });

  app.post("/api/v1/add/home", async (req, res) => {
    console.log("ADD A NEW HOME");

    const { title, imageUrl, description, rating, location } = req.body;

    try {
      const home = await Home.findOne({ title }); //check if the home alredy exists
      if (home) {
        res.status(400).json({ message: "Home already exist!" });
      }

      homeFields = {
        title,
        imageUrl,
        description,
        ratings,
        location,
      };

      const response = await Home.create(homeFields);

      res.status(201).json({ message: "Added a New Home : ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
};
