const mongoose = require("mongoose");
const Service = mongoose.model("service");

module.exports = (app) => {
  app.get("/api/v1/get/service", async (req, res) => {
    console.log("GET Service");

    try {
      const response = await Service.find();
      res.status(201).json({ message: "Featured Service: ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
  app.post("/api/v1/add/service", async (req, res) => {
    console.log("ADDED A NEW Service");

    const {
      name,
      location,
      images,
      rating,
      serviceName,
      serviceDescription,
      price,
      totalReviews,
    } = req.body;

    try {
      const serivce = await Service.findOne({ name }); //check if the service already exists
      if (serivce) {
        res.status(400).json({ message: "Service already exist!" });
      }

      serviceFields = {
        name,
        location,
        images,
        rating,
        serviceName,
        serviceDescription,
        totalReviews,
        price,
      };

      const response = await Service.create(serviceFields);

      res.status(201).json({ message: "Added a New Service : ", response });
    } catch (error) {
      console.log("ERROR: ", error);
    }
  });
};
