# Basic storage for riki (mostly for testing usage).

P = require 'bluebird'

class TestStorage

  constructor: ->
    @types = {}
    @data = {}

  addType: (typeName, schema) ->
    @types[typeName] = schema
    @data[typeName] = {}
    P.resolve()

  getType: (typeName) ->
    if typeName of @types
      P.resolve @types[typeName]
    else
      P.reject (new Error 'Type "' + typeName + '" not found')

  addObject: (typeName, data) ->
    id = data.id
    @data[typeName][id] = data
    P.resolve id

  getObject: (typeName, id) ->
    if typeName of @data
      if id of @data[typeName]
        P.resolve @data[typeName][id]
      else
        P.reject (new Error 'Object of type "' + typeName +
                            '" with id ' + id + ' not found')
    else
      P.reject (new Error 'Type "' + typeName + '" not found')

module.exports = TestStorage
