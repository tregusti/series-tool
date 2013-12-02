var path = require('path');

exports.parse = function(filepath) {
  var file = path.basename(filepath);
  var m   = file.match(/^(.*?)\.S(\d\d)E(\d\d)(?:-(\d\d))?/i);
  if (m) {
    var info = {};
    info.show    = m[1].replace(/\./g, ' ').replace(/`/g, '');
    info.season  = +m[2];
    info.episode = {
      from : +m[3],
      to   : m[4] !== undefined ? +m[4] : +m[3]
    };
    info.file = file;
    info.path = filepath;
    handleExceptions( info );
    return info;
  }
  return null;
};

function handleExceptions(info) {
  if (info.show === 'The Newsroom 2012') {
    info.show = 'The Newsroom (2012)';
  }
}