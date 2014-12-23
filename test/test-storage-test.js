/**
 * Test for very simple testing storage.
 */

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

});
