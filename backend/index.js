const express = require("express");
const app = express();
const promBundle = require("express-prom-bundle");

app.use("/*", promBundle({ includePath: true }));

app.get("/status", (req, res) => res.send("i am healthy"));
app.get("/hello", (req, res) => res.send("ok"));

app.listen(4000);
