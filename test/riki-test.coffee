riki = require '../'
require 'should'

describe 'riki', ->

  rk = null
  beforeEach ->
    rk = riki()
    rk.addType 'test-type', title:'Test type'

  it 'should instantiate', ->
    # with no explicit storage
    rk.storage.should.be.ok
    rk.storage.should.not.be.equal ts

    # with explicit storage
    ts = new riki.TestStorage
    r = riki storage:ts
    r.storage.should.be.eql ts

  it 'should add types', ->
    rk.getType 'test-type'
      .then (type) ->
        type.title.should.eql 'Test type'
        type.id.should.eql 'http://localhost/types/test-type'
        type.$schema.should.eql 'http://json-schema.org/draft-04/schema#'
        type.type.should.eql 'object'

  it 'should fail when getting nonexistent type', ->
    rk.getType 'missing-type'
      .then (-> no.should.be.ok),
        ((err) -> err.message.should.endWith 'not found')

  it 'should store objects', ->
    rk.addObject 'test-type', id:42
      .then (-> rk.getObject 'test-type', 42)
      .then ((obj) -> obj.id.should.eql 42)

  it 'should fail when getting nonexistent object', ->
    rk.getObject 'test-type', id:1
      .then (-> no.should.be.ok),
        ((err) -> err.message.should.endWith 'not found')

  it 'should reject objects that don\'t match schema', ->
    rk.addType 'type2',
        type: 'object',
        properties:
          a:
            type: 'number'
        required: ['a']
      .then (-> rk.addObject 'type2', id:42)
      .then (-> no.should.be.ok),
        ((err) -> err.message.should.startWith 'Missing required property')
