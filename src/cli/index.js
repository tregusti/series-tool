var child_process = require('child_process');
var util = require('util');
var path = require('path');

var api = require('../api');

var cli = {
  subtitle: function( argv ) {
    var filename = path.basename(argv._[1]);
    var url = api.subtitle(filename);
    if (url) child_process.exec(util.format('open "%s"', url));
  },
  move: function( argv ) {
    var files = argv._.slice(1);
    var destination = argv.destination;
    if (destination && files && files.length > 0) {
      api.move({
        files: files,
        destination: destination
      });
    }
  }
};

/**
* Parse command-line arguments.
*
* Inspects the arguments and calls the appropriate action.
*
* @param {Object} argv An optimist.argv object.
* @see http://michaelbrooks.ca/deck/jsconf2013/
*/
exports.run = function( argv ) {
  if (argv._[0] === 'subtitle') {
    cli.subtitle( argv );
  } else if (argv._[0] === 'move') {
    cli.move( argv );
  }
};
