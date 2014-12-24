# Test for basic testing storage.

riki = require '../'
require 'should'

describe 'test-storage', ->

  storage = null
  beforeEach ->
    storage = new riki.TestStorage
    storage.addType 'test-type', {title: 'Test type'}

  it 'should store types', ->
    storage.getType 'test-type'
      .then (type) -> type.title.should.eql 'Test type'

  it 'should fail when getting nonexistent type', ->
    storage.getType('missing-type')
      .then(
        -> no.should.be.ok,
        (err) -> err.message.should.eql 'Type "missing-type" not found'
      )

  it 'should store objects', ->
    storage.addObject 'test-type', {id: 42}
      .then (id) ->
        id.should.eql 42
        storage.getObject 'test-type', 42
      .then (obj) -> obj.id.should.eql 42

  it 'should fail when getting nonexistent object', ->
    storage.getObject 'test-type', 1
      .then(
        -> no.should.be.ok,
        (err) -> err.message.should.eql 'Object of type "test-type" with ' +
                                        'id 1 not found'
      )

  it 'should fail when getting object of nonexistent type', ->
    storage.getObject 'missing-type', 1
      .then(
        -> no.should.be.ok,
        (err) -> err.message.should.eql 'Type "missing-type" not found'
      )
