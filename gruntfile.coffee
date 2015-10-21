module.exports = (grunt)->
  require('load-grunt-tasks')(grunt)
  require('time-grunt')(grunt)

  grunt.initConfig
    clean:
      vendor: ['vendor.js']
      templates: ['index.html']
      css: ['app.css', 'app.min.css']
      angular: ['app.js', 'app.min.js']
    concat:
      vendor:
        src: [
          'bower_components/jquery/dist/jquery.min.js'
          'bower_components/bootstrap/dist/js/bootstrap.min.js'
          'bower_components/angular/angular.min.js'
          'bower_components/angular-route/angular-route.min.js'
          'bower_components/lodash/lodash.min.js'
        ]
        dest: 'vendor.js'
      templates:
        src: [
          'templates/templates.prefix.html'
          'templates/html/*.html'
          'templates/templates.suffix.html'
        ]
        dest: 'index.html'
      css:
        src: [
          'assets/css/bootstrap.min.css'
          'assets/css/animate.css'
          'assets/css/font-awesome.min.css'
          'assets/css/font.css'
          'assets/css/style.css'
        ]
        dest: 'app.css'
      angular:
        src: [
          'assets/js/angular/app.js'
          'assets/js/angular/*/*.js'
          'assets/js/angular/run.js'
        ]
        dest: 'app.js'
    cssmin:
      css:
        src: 'app.css'
        dest: 'app.min.css'
    ngmin:
      angular:
        src: ['app.js']
        dest: 'app.min.js'
    uglify:
      angular:
        options:
          mangle: false
        files:
          'app.min.js': ['app.min.js']
    watch:
      templates:
        files: [
          'templates/templates.prefix.html'
          'templates/html/*.html'
          'templates/templates.suffix.html'
        ]
        tasks: ['templates']
      css:
        files: [
          'assets/css/*.css'
        ]
        tasks: ['css']
      angular:
        files: [
          'assets/js/angular/app.js'
          'assets/js/angular/*/*.js'
          'assets/js/angular/run.js'
        ]
        tasks: ['angular']

  grunt.registerTask 'vendor', ['clean:vendor', 'concat:vendor']
  grunt.registerTask 'templates', ['clean:templates', 'concat:templates']
  grunt.registerTask 'css', ['clean:css', 'concat:css', 'cssmin:css']
  grunt.registerTask 'angular', ['clean:angular', 'concat:angular', 'ngmin:angular', 'uglify:angular']
  grunt.registerTask 'default', ['vendor', 'templates', 'css', 'angular', 'watch']
