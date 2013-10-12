LocalStorage = require('node-localstorage').LocalStorage
localStorage = new LocalStorage('./scratch')
class exports.Storage
  constructor: (@app)->
    @app.on 'getUser', @getUser
    @app.on 'updateUser', @updateUser
    @app.on 'establishUser', @establishUser
    unless localStorage
      @app.emit 'print', 'you will need a modern browser with local storage to persist your game, we reccommend google chrome.'
 
  establishUser: =>
    @app.emit 'getUser', (user)=>
      if user
        @app.emit 'getLocation',
          x: user.x, 
          y: user.y, 
          fn: (data)=> @app.emit('printPlot', data)
      else
        @createUser()
        @app.emit 'getLocation',
          x: 0, 
          y: 0, 
          fn: (data)=> @app.emit('printPlot', data)

  getUser: (fn)=>
    fn JSON.parse localStorage.getItem 'abyssUser'

  createUser: =>
    @updateUser null, { x: 0, y: 0 }

  updateUser: (options)->
    localStorage.setItem 'abyssUser', JSON.stringify options