'use strict';

require('coffee-script/register');

var gulp   = require('gulp');
var plugins = require('gulp-load-plugins')();

var paths = {
    lint: ['./gulpfile.js', './lib/**/*.js'],
    watch: ['./gulpfile.js', './lib/**', './test/**/*.js', '!test/{temp,temp/**}'],
    tests: ['./test/**/*.coffee', '!test/{temp,temp/**}'],
    source: ['./lib/*.coffee']
};

var plumberConf = {};

if (process.env.CI) {
    plumberConf.errorHandler = function(err) {
        throw err;
    };
}

gulp.task('lint', function () {
    gulp.src(paths.source)
    .pipe(plugins.coffeelint())
    .pipe(plugins.coffeelint.reporter());
});

gulp.task('istanbul', function (cb) {
    gulp.src(paths.source)
    .pipe(plugins.coffeeIstanbul({includeUntested: true})) // Covering files
    .pipe(plugins.coffeeIstanbul.hookRequire())
    .on('finish', function () {
        gulp.src(paths.tests)
        .pipe(plugins.plumber(plumberConf))
        .pipe(plugins.mocha())
        .pipe(plugins.coffeeIstanbul.writeReports()) // Creating the reports after tests runned
        .on('finish', function() {
            process.chdir(__dirname);
            cb();
        });
    });
});

gulp.task('bump', ['test'], function () {
    var bumpType = plugins.util.env.type || 'patch'; // major.minor.patch

    return gulp.src(['./package.json'])
    .pipe(plugins.bump({ type: bumpType }))
    .pipe(gulp.dest('./'));
});

gulp.task('watch', ['test'], function () {
    gulp.watch(paths.watch, ['test']);
});

gulp.task('test', ['lint', 'istanbul']);

gulp.task('release', ['bump']);

gulp.task('default', ['test']);
