# Basic storage for riki (mostly for testing usage).

P = require 'bluebird'

class TestStorage

  constructor: ->
    @types = {}
    @data = {}

  addType: (name, schema) ->
    @types[name] = schema
    @data[name] = {}
    P.resolve()

  getType: (name) ->
    if name of @types
      P.resolve @types[name]
    else
      P.reject (new Error 'Type "' + name + '" not found')

  addObject: (type, obj) ->
    id = obj.id
    @data[type][id] = obj
    P.resolve id

  getObject: (type, id) ->
    if type of @data
      if id of @data[type]
        P.resolve @data[type][id]
      else
        P.reject (new Error 'Object of type "' + type +
                            '" with id ' + id + ' not found')
    else
      P.reject (new Error 'Type "' + type + '" not found')

module.exports = TestStorage
