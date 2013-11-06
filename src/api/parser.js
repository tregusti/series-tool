var path = require('path');

exports.parse = function(filepath) {
  var file = path.basename(filepath);
  var m   = file.match(/^(.*?)\.S(\d\d)E(\d\d)(?:-(\d\d))?/);
  if (m) {
    var out = {};
    out.show    = m[1].replace(/\./g, ' ').replace(/`/g, '');
    out.season  = +m[2];
    out.episode = {
      from : +m[3],
      to   : m[4] !== undefined ? +m[4] : +m[3]
    };
    out.file = file;
    out.path = filepath;
    return out;
  }
  return null;
};
