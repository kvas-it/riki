/**
 * Test for very simple testing storage.
 */

/* jshint expr: true */

var riki = require('../');
require('should');

describe('test-storage', function () {

    var storage;

    beforeEach(function () {
        storage = new riki.TestStorage();
    });

    it('should store types', function () {
        return storage.addType('test-type', {title: 'Test type'})
        .then(function () {
            return storage.getType('test-type');
        })
        .then(function (type) {
            type.title.should.eql('Test type');
        });
    });

    it('should fail if type doesn\'t exist', function () {
        return storage.getType('test-type').then(function () {
            false.should.be.ok;
        }, function (err) {
            err.message.should.eql('Type "test-type" not found');
        });
    });

    it('should store objects', function () {
        return storage.addType('test-type', {title: 'Test type'})
        .then(function () {
            return storage.addObject('test-type', {id: 42});
        })
        .then(function (id) {
            id.should.eql(42);
            return storage.getObject('test-type', 42);
        })
        .then(function (obj) {
            obj.id.should.eql(42);
        });
    });

});
