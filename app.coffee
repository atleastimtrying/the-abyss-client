events = require 'events'
s = require './storage'
l = require './location'
p = require './printer'
c = require './commands'
m = require './movement'
class exports.App extends events.EventEmitter
  constructor: ->
    @storage = new s.Storage(@)
    @location = new l.Location(@)
    @printer = new p.Printer(@)
    @commands = new c.Commands(@)
    @movement = new m.Movement(@)
    @emit 'print',  'Welcome to the abyss, a text adventure game type help for a list of commands.'
    @emit 'establishUser'