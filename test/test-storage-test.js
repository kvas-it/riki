/**
 * Test for very simple testing storage.
 */

/* jshint expr: true */

var riki = require('../');
require('should');

describe('test-storage', function () {

    it('should store types', function () {
        var storage = new riki.TestStorage();

        return storage.addType('test-type', {title: 'Test type'})
        .then(function () {
            return storage.getType('test-type');
        })
        .then(function (type) {
            type.title.should.eql('Test type');
        });
    });

    it('should fail if type doesn\'t exist', function () {
        var storage = new riki.TestStorage();

        return storage.getType('test-type').then(function () {
            false.should.be.ok;
        }, function (err) {
            err.message.should.eql('Type "test-type" not found');
        });
    });

});
