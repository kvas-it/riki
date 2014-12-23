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
    if (name in this.types) {
        return P.resolve(this.types[name]);
    } else {
        return P.reject(new Error('Type "' + name + '" not found'));
    }
};

module.exports = TestStorage;
