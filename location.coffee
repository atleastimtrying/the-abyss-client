http = require 'http'

class exports.Location
  constructor: (@app)->
    @app.on 'getLocation', @get

  get: (options)=>
    url = "http://the-abyss.herokuapp.com/plots/fetch.json?x=#{options.x}&y=#{options.y}"
    console.log url
    http.get(url, (res)->
      data = ''
      res.on 'data', (chunk) -> data += chunk
      res.on 'end', () ->
        options.fn JSON.parse data
    ).on 'error', (e) -> console.log "Got error: ", e