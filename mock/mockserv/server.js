
const express = require('express')
const app = express()
var path = require('path')
var bodyParser = require('body-parser')
app.use(express.static(path.join(__dirname, 'build')));

var dataController = require('./dataController');

app.get('/data/2.5/weather', dataController.getData);

const port = 3002;

app.listen(process.env.PORT || port);
