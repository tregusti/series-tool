var fs = require('fs');
var path = require('path');

var parser = require('./parser');

function help() {
  var file = path.join(__dirname, 'help', 'move.txt');
  var text = fs.readFileSync(file, 'utf-8');
  console.log(text);
  process.exit(0);
}

function moveFile(dest, from) {
  var info = parser.parse(from);
  var show = info.show;
  var create = true;
  fs.readdirSync(dest).forEach(function(dir) {
    if (path.basename(dir).toLowerCase() === show.toLowerCase()) {
      create = false;
      show = path.basename(dir);
    }
  });
  if (create) {
    fs.mkdirSync(path.join(dest, show));
  }
  
  var to = path.join(dest, show, 'Season ' + info.season, info.file);
  fs.renameSync(from, to);
  // console.dir(["move", from, to]);
}

module.exports = function(options) {
  if (options.help)
    return help();

  if (!options.destination) {
    throw new TypeError('Destination path not set');
  }
  
  var destination = path.resolve(options.destination);
  if (!fs.existsSync(destination)) {
    throw new TypeError('Destination path does not exist');
  }
  
  options.files.forEach(moveFile.bind(null, destination));
};
