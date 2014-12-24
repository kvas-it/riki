riki = require '../'
require 'should'

describe 'riki', ->

    it 'should instantiate', ->
      ts = new riki.TestStorage

      # with no explicit storage
      r = riki()
      r.storage.should.be.ok
      r.storage.should.not.be.equal ts

      # with explicit storage
      r = riki storage:ts
      r.storage.should.be.eql ts
