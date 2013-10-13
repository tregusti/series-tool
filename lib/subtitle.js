var util = require('util');

var baseurl = 'http://subscene.com/subtitles';
var SEASONS = (' first second third fourth fifth sixth' +
               ' seventh eighth ninth tenth').split(' ');

function normalizeName(name) {
  return name
    .toLowerCase()
    .replace(/\./g, '-');
}

exports.url = function( input ) {
  var m = input.match(/^(.+?)\.S(\d+)E([\d-]+).*$/i);
  if (m) {
    var name   = normalizeName(m[1]);
    var season = SEASONS[+m[2]];
    return util.format('%s/%s-%s-season', baseurl, name, season);
  }
  
  return null;
};
