var fs = require('fs');
var path = require('path');

function help() {
  var file = path.join(__dirname, 'help', 'move.txt');
  var text = fs.readFileSync(file, 'utf-8');
  console.log(text);
  process.exit(0);
}

function moveFile(dest, from) {
  var name = path.basename(from);
  var m = name.match(/^(.+?)\.S(\d+)E([\d-]+).*$/i);
  var to = path.join(dest, m[1], 'Season ' + (+m[2]), name);
  fs.renameSync(from, to);
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
