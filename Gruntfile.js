'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    // Task configuration.
    coffeelint: {
      options: {
        no_trailing_whitespace : { level: 'error' },
        arrow_spacing          : { level: 'error' },
        cyclomatic_complexity  : { level: 'error', value: 10 },
        indentation            : { level: 'error', value: 2 },
        line_endings           : { level: 'error', value: 'unix' },
        max_line_length        : { level: 'error', value: 80 },
        no_empty_param_list    : { level: 'error' },
      },
      specs: {
        src: 'specs/**/*.coffee'
      }
    },
    jshint: {
      options: {
        
        node          : true,
        newcap        : true,
        trailing      : true,
        undef         : true,
        maxcomplexity : 10,
        maxlen        : 80,
        quotmark      : 'single',
        globals       : {}
        
      },
      gruntfile: {
        src: 'Gruntfile.js'
      },
      source: {
        src: [
          'lib/**/*.js',
          'specs/**/*.js'
        ]
      }
    },
    mochaTest: {
      specs: {
        options: {
          require: ['./specs/helper'],
        },
        src: 'specs/**/*.spec.coffee'
      }
    },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      js: {
        files: [
          'lib/**/*.js',
          'specs/**/*.js'
        ],
        tasks: ['jshint:source', 'mochaTest']
      },
      coffee: {
        files: [
          'specs/**/*.coffee'
        ],
        tasks: ['coffeelint:specs', 'mochaTest']
      }
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');

  // Default task.
  grunt.registerTask('default', ['jshint', 'coffeelint', 'mochaTest']);

};
