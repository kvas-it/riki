###
Simple testing storage.
###

P = require 'bluebird'

class TestStorage

    constructor: () ->
        @types = {}
        @data = {}

    addType: (name, schema) ->
        @types[name] = schema
        @data[name] = {}
        return P.resolve()

    getType: (name) ->
        if name of @types
            P.resolve @types[name]
        else
            P.reject (new Error 'Type "' + name + '" not found')

    addObject: (type, obj) ->
        id = obj.id
        @data[type][id] = obj
        P.resolve id

    getObject: (type, id) -> P.resolve @data[type][id]

module.exports = TestStorage
