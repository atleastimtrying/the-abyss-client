class exports.Movement
  constructor: (@app)->
    @app.on('north', @north)
    @app.on('south', @south)
    @app.on('east', @east)
    @app.on('west', @west)

  blocked: (plot, label)->
    current_plot = plot.plot
    switch label
      when "north" then current_plot.north_wall or plot.north.south_wall
      when "south" then current_plot.south_wall or plot.south.north_wall
      when "east" then current_plot.east_wall or plot.east.west_wall
      when "west" then current_plot.west_wall or plot.west.east_wall

  travel: (xmod, ymod, user)=>
    x = user.x + xmod
    y = user.y + ymod
    @app.trigger 'getLocation',
      x: x, 
      y: y, 
      fn: (data)-> 
        @app.trigger('printPlot', data)
        @app.trigger 'updateUser', { x: x, y: y }

  move: (label, xmod, ymod)=>
    @app.trigger 'getUser', (user)=>
      @app.trigger 'getLocation',
        x: user.x, 
        y: user.y, 
        fn: (plot)=> 
          if @blocked(plot, label)
            @app.trigger('print', "The way to the #{label} is barred!")
          else
            @app.trigger 'print',  "You travel #{label}"
            @travel(xmod, ymod, user)
  
  north: => @move('north', 0, 1)
  south: => @move('south', 0, -1)
  east: => @move('east', 1, 0)
  west: => @move('west', -1, 0)