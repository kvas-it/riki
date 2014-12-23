/**
 * Test for very simple testing storage.
 */

var riki = require('../');
require('should');

describe('test-storage', function () {

    it('should create storage', function () {
        var storage = new riki.TestStorage();
    });

});
