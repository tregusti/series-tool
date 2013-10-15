#!/usr/bin/env node

var argv = require('optimist').argv;
var cli  = require('../src/cli');

cli.run(argv);
