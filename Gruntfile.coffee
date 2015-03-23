module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'script/index.js': 'script/index.coffee'

    stylus:
      compile:
        options:
          compress: false
          linenos: true
          'include css': true
          paths: ['bower_components']
        files:
          'style/index.css': 'style/index.styl'

    browserify:
      compile:
        options:
          transform: ['coffeeify']
          shim: grunt.file.readJSON('shim.json')
        files:
          'script/index.js': 'script/index.coffee'

    clean:
      public: [
        'public/script.js'
        'public/style.css'
        'public/sprite.png'
        'script/index.js'
        'style/index.css'
      ]

    concat:
      js:
        src: [
          'bower_components/jquery/dist/jquery.js'
          'bower_components/bootstrap/dist/js/bootstrap.js'
          'script/index.js'
        ]
        dest: 'public/script.js'
      css:
        src: ['bower_components/bootstrap/dist/css/bootstrap.css',
              'bower_components/bootstrap/dist/css/bootstrap-theme.css',
              'style/index.css'
        ]
        dest: 'public/style.css'
      cssMap:
        src: ['bower_components/bootstrap/dist/css/bootstrap.css.map']
        dest: 'public/bootstrap.css.map'

    uglify:
      compile:
        files:
          'public/script.min.js': 'public/script.js'

    cssmin:
      compile:
        files:
          'public/style.min.css': 'public/style.css'

    rename:
      compile:
        files:
          'public/style.css': 'public/style.min.css'
          'public/script.js': 'public/script.min.js'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-rename'

  grunt.registerTask 'dev', ['clean', 'coffee', 'browserify', 'stylus', 'concat']
  grunt.registerTask 'dist', ['dev', 'uglify', 'cssmin', 'rename']