/**
 * Simple testing storage.
 */

var P = require('bluebird');

function TestStorage() {
    this.types = {};
}

TestStorage.prototype.addType = function (name, schema) {
    this.types[name] = schema;
    return P.resolve();
};

TestStorage.prototype.getType = function (name) {
    return P.resolve(this.types[name]);
};

module.exports = TestStorage;
