# riki -- a wiki for structured data
# https://github.com/kvas-it/riki
#
# Copyright (c) 2014 Vasily Kuznetsov
# Licensed under the MIT license.

TestStorage = require './test-storage'


class Riki

  constructor: (options) ->
    @storage = options.storage or new TestStorage


riki = (options = {}) -> new Riki options
riki.TestStorage = TestStorage

module.exports = riki
