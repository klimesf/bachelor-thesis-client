module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'public/script.js': 'script/index.coffee'

    stylus:
      compile:
        options:
          compress: false
          linenos: true
          'include css': true
          paths: ['bower_components']
        files:
          'public/style.css': 'style/index.styl'

    browserify:
      compile:
        options:
          transform: ['coffeeify']
          shim: grunt.file.readJSON('shim.json')
        files:
          'public/script.js': 'script/index.coffee'

    clean:
      public: [
        'public/script.js'
        'public/style.css'
        'public/sprite.png'
      ]

    concat:
      bootstrap:
        src: [
          'bower_components/bootstrap/dist'
        ]



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
#  grunt.loadNpmTasks 'grunt-spritesmith'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-rename'

  grunt.registerTask 'dev', ['clean', 'coffee', 'browserify', 'stylus']
  grunt.registerTask 'dist', ['dev', 'uglify', 'cssmin', 'rename']