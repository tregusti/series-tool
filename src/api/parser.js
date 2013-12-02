var path = require('path');

exports.parse = function(filepath) {
  var file = path.basename(filepath);
  var m   = file.match(/^(.*?)(?:\.(\d\d\d\d))?\.S(\d\d)E(\d\d)(?:-(\d\d))?/i);
  if (m) {
    var info     = {};
    info.show    = m[1].replace(/\./g, ' ').replace(/`/g, '');
    info.year    = m[2] ? +m[2] : null
    info.season  = +m[3];
    info.episode = {
      from : +m[4],
      to   : m[5] !== undefined ? +m[5] : +m[4]
    };
    info.file = file;
    info.path = filepath;
    return info;
  }
  return null;
};
