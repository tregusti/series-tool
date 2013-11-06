var util = require('util');

var parser = require('./parser');

var baseurl = 'http://subscene.com/subtitles';
var SEASONS = (' first second third fourth fifth sixth' +
               ' seventh eighth ninth tenth').split(' ');

function normalizeName(name) {
  return name
    .toLowerCase()
    .replace(/ +/g, '-');
}

module.exports = function( input ) {
  var info = parser.parse(input);
  if (info) {
    var name   = normalizeName(info.show);
    var season = SEASONS[info.season];
    return util.format('%s/%s-%s-season', baseurl, name, season);
  }
  return null;
};
