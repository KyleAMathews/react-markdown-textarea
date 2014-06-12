gulp = require 'gulp'
open = require 'open'
connect = require 'gulp-connect'
source = require('vinyl-source-stream')
watchify = require('watchify')
browserify = require 'browserify'

# Load plugins
$ = require('gulp-load-plugins')()

isProduction = process.env.NODE_ENV is "production"

# React code
gulp.task('scripts', ->
    return gulp.src('client.coffee', read: false)
        .pipe($.browserify({
            insertGlobals: true
            extensions: '.cjsx'
            transform: ['coffee-reactify', 'envify']
            debug: !isProduction
        }))
        .pipe($.if(isProduction, $.uglify()))
        .pipe($.rename('bundle.js'))
        .pipe(gulp.dest('public/'))
        .pipe($.size())
        .pipe($.connect.reload())
)

# CSS
gulp.task('css', ->
  gulp.src(['styles/*.sass', 'styles/*.scss'])
    .pipe($.compass({
      css: 'public/'
      sass: 'styles'
      image: 'styles/images'
      style: 'nested'
      comments: false
      bundle_exec: true
      time: true
      require: ['susy', 'modular-scale', 'normalize-scss', 'sass-css-importer', 'breakpoint']
    }))
    .on('error', (err) ->
      console.log err
    )
    .pipe($.size())
    .pipe(connect.reload())
)

# Connect
gulp.task 'connect', -> connect.server({
  root: ['public']
  port: 9000,
  livereload: true
})

gulp.task 'default', ->
  gulp.start 'build'

gulp.task 'build', ['scripts', 'css']

gulp.task 'watch', ['css', 'connect'], ->
  gulp.watch(['styles/*'], ['css'])

  # https://github.com/gulpjs/gulp/blob/master/docs/recipes/fast-browserify-builds-with-watchify.md
  bundler = watchify('./client.coffee', {
    extensions: ['.coffee', '.cjsx']
  })
  bundler.transform('coffee-reactify')
  rebundle = ->
    return bundler.bundle({debug: true})
      .pipe(source('bundle.js'))
      .pipe(gulp.dest('./public'))
      .pipe($.connect.reload())

  bundler.on('update', rebundle)
  rebundle()
