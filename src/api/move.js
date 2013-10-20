var fs = require('fs');
var path = require('path');

function help() {
  var file = path.join(__dirname, 'help', 'move.txt');
  var text = fs.readFileSync(file, 'utf-8');
  console.log(text);
  process.exit(0);
}

module.exports = function(options) {
  if (options.help) return help();
};
