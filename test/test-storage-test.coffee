# Test for basic testing storage.

riki = require '../'
require 'should'

describe 'test-storage', () ->

    storage = null
    beforeEach ->
        storage = new riki.TestStorage
        storage.addType 'test-type', {title: 'Test type'}

    it 'should store types', () ->
        storage.getType 'test-type'
        .then (type) -> type.title.should.eql 'Test type'

    it 'should fail if type doesn\'t exist', () ->
        storage.getType('missing-type')
        .then(
            -> no.should.be.ok,
            (err) -> err.message.should.eql 'Type "missing-type" not found'
        )

    it 'should store objects', () ->
        storage.addObject 'test-type', {id: 42}
        .then (id) ->
            id.should.eql(42)
            storage.getObject('test-type', 42)
        .then (obj) -> obj.id.should.eql 42
