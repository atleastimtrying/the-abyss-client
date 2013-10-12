class exports.Commands
  constructor: (@app)->
    input = process.openStdin()
    input.setEncoding 'utf8'
    input.on 'data', @interpret

  interpret: (command)=>
    if command isnt ''
      potential = @commands[command.toLowerCase()]
      console.log command
      if potential
        potential() 
      else
        @app.emit 'print', "Although #{command} sounds like a great idea, It doesn&rsquo;t seem to be the right thing to do right now."
  
  commands :
    'help': ->
      @app.emit 'print', 'The abyss is played by entering text commands in the window below here are some of the commands available'
      @app.emit 'print', '<span class="highlight">help</span> : will bring up this screen to remind you of your options'
      @app.emit 'print', '<span class="highlight">look</span> : will show you the description of where you are'
      @app.emit 'print', '<span class="highlight">north</span> : will take you one area north'
      @app.emit 'print', '<span class="highlight">south</span> : will take you one area south'
      @app.emit 'print', '<span class="highlight">east</span> : will take you one area east'
      @app.emit 'print', '<span class="highlight">west</span> : will take you one area west'
      @app.emit 'print', '<span class="highlight">home</span> : will take you back to the entrance'
      @app.emit 'print', '<span class="highlight">where</span> : will tell you your current coordinates'

    'north': -> @app.emit('north')
    'n': -> @app.emit('north')
    'south': -> @app.emit('south')
    's': -> @app.emit('south')
    'east': -> @app.emit('east')
    'e': -> @app.emit('east')
    'west': -> @app.emit('west')
    'w': -> @app.emit('west')
    'home': ->
      @app.emit 'print', 'With a twist in reality you are transported back'
      @app.emit 'updateUser', {x: 0, y: 0}
      @app.emit 'getLocation',
        x: 0, 
        y: 0, 
        fn: (data)-> @app.emit('printPlot', data)
    
    'where': ->
      @app.emit 'getUser', (user)->
        @app.emit 'print', "By looking at the stars, some moss and the curve of the horizon you determine that your coordinates must be <br> <span class='highlight'>#{user.x}, #{user.y}</span>!"

    'look': ->
      @app.emit 'print', 'you look around you'
      @app.emit 'getUser', (user)->
        @app.emit 'getLocation',
          x: user.x, 
          y: user.y, 
          fn: (data)-> @app.emit('printPlot', data)    