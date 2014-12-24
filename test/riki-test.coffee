riki = require '../'
require 'should'

describe 'riki', ->

  rk = null
  beforeEach -> rk = riki()

  it 'should instantiate', ->
    # with no explicit storage
    rk.storage.should.be.ok
    rk.storage.should.not.be.equal ts

    # with explicit storage
    ts = new riki.TestStorage
    r = riki storage:ts
    r.storage.should.be.eql ts

  it 'should add types', ->
    rk.addType 'test-type', title:'Test type'
      .then ->
        rk.getType 'test-type'
      .then (type) ->
        type.title.should.eql 'Test type'

  it 'should fail when getting nonexistent type', ->
    rk.getType 'missing-type'
      .then(
        -> no.should.be.ok,
        (err) -> err.message.should.endWith 'not found'
      )

