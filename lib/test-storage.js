/**
 * Simple testing storage.
 */

var P = require('bluebird');

function TestStorage() {
    this.types = {};
    this.data = {};
}

TestStorage.prototype.addType = function (name, schema) {
    this.types[name] = schema;
    this.data[name] = {};
    return P.resolve();
};

TestStorage.prototype.getType = function (name) {
    if (name in this.types) {
        return P.resolve(this.types[name]);
    } else {
        return P.reject(new Error('Type "' + name + '" not found'));
    }
};

TestStorage.prototype.addObject = function (type, obj) {
    var id = obj.id;
    this.data[type][id] = obj;
    return P.resolve(id);
};

TestStorage.prototype.getObject = function (type, id) {
    return P.resolve(this.data[type][id]);
};

module.exports = TestStorage;
