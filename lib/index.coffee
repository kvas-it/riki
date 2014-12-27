# riki -- a wiki for structured data
# https://github.com/kvas-it/riki
#
# Copyright (c) 2014 Vasily Kuznetsov
# Licensed under the MIT license.

_ = require 'lodash'
tv4 = require 'tv4'

TestStorage = require './test-storage'


SCHEMA_URL = 'http://json-schema.org/draft-04/schema#'
TYPE_PREFIX = 'types/'
OBJ_PREFIX = 'objects/'


class Riki

  constructor: (options) ->
    @storage = options.storage or new TestStorage
    @baseUrl = options.baseUrl or 'http://localhost/'

  addType: (typeName, schema) ->
    unless 'id' of schema
      schema.id = @baseUrl + TYPE_PREFIX + typeName
    unless 'type' of schema
      schema.type = 'object'
    schema.$schema = SCHEMA_URL
    @storage.addType typeName, schema

  getType: (typeName) ->
    @storage.getType typeName

  _validate: (data, schema) ->
    res = tv4.validateResult data, schema
    if res.valid
      data
    else
      throw res.error

  addObject: (typeName, data) ->
    @getType typeName
      .bind @
      .then (schema) ->
        @_validate data, schema
      .then (data) ->
        @storage.addObject typeName, data

  getObject: (typeName, id) ->
    @storage.getObject typeName, id


riki = (options = {}) -> new Riki options
riki.TestStorage = TestStorage

module.exports = riki
