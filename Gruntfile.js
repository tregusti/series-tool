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
        max_line_length        : { level: 'error', value: 100 },
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
        maxlen        : 100,
        quotmark      : 'single',
        globals       : {}
        
      },
      gruntfile: {
        src: 'Gruntfile.js'
      },
      source: {
        src: [
          'src/**/*.js',
          'bin/**/*.js',
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
    concurrent: {
      'default' : ['jshint', 'coffeelint', 'mochaTest'],
      'js'      : ['jshint', 'mochaTest'],
      'coffee'  : ['coffeelint', 'mochaTest'],
    },
    watch: {
      gruntfile: {
        files: '<%= jshint.gruntfile.src %>',
        tasks: ['jshint:gruntfile']
      },
      js: {
        files: [
          'src/**/*.js',
          'specs/**/*.js'
        ],
        tasks: ['concurrent:js']
      },
      coffee: {
        files: [
          'specs/**/*.coffee'
        ],
        tasks: ['concurrent:coffee']
      }
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-concurrent');

  // Default task.
  grunt.registerTask('default', ['concurrent:default']);

};
