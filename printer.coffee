class exports.Printer
  constructor: (@app)->
    @app.on 'print', @print
    @app.on 'printPlot', @printPlot 
  
  print: (message)->
    console.log message + '\n'
  
  getDirections: (plot)->
    direction = ""
    direction += "<span class=\"highlight\">north</span> lies #{plot.north.title}<br>" unless plot.plot.north_wall or plot.north.south_wall
    direction += "<span class=\"highlight\">south</span> lies #{plot.south.title}<br>" unless plot.plot.south_wall or plot.south.north_wall
    direction += "<span class=\"highlight\">east</span> lies #{plot.east.title}<br>" unless plot.plot.east_wall or plot.east.west_wall
    direction += "<span class=\"highlight\">west</span> lies #{plot.west.title}<br>" unless plot.plot.west_wall or plot.west.east_wall
    direction

  printPlot: (plot)=>
    @print '<h2>' + plot.plot.title + '</h2>'
    @print plot.plot.description
    @print @getDirections plot