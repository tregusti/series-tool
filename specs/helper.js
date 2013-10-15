var chai      = require('chai');
var sinon     = require('sinon');
var sinonChai = require('sinon-chai');

chai.use(sinonChai);

global.expect = chai.expect;
global.should = chai.should();
global.sinon  = sinon;