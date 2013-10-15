#!/usr/bin/env node

var argv = require('optimist').argv;
var cli  = require('../lib/cli');

cli.run(argv);
