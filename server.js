const express = require("express");
const fs = require("fs");
const util = require("util");
const readFileAsync = util.promisify(fs.readFile);
const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

class Config {
  constructor() {
    this.conf;
    this.config;
  }
  async read() {
    const data = await readFileAsync("db/db.json", "utf8");
    this.conf = JSON.parse(data);
    this.myapplication = {
      version: this.conf[0].version,
      lastcommitsha: process.env.COMMIT_SHA,
      description: "pre interview technical test"
    }
  }
}

const configs = new Config();

const init = async () => {
  try {
    await configs.read();
    const PORT = configs.conf[0].service_port || 4000;
    app.listen(PORT, function () {
      logger("App listening on PORT " + PORT);
    });
  } catch (err) {
    logger(err);
  }
}
init();

app.get("/info", (req, res) => {
  logger("read api config =>");
  logger(configs.myapplication);
  return res.json(configs.myapplication);
})

const logger = (msg) => { if (configs.conf[0].log_level === "INFO") { console.log(msg); } };