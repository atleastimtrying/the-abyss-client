// Generated by CoffeeScript 1.6.2
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  exports.Movement = (function() {
    function Movement(app) {
      this.app = app;
      this.west = __bind(this.west, this);
      this.east = __bind(this.east, this);
      this.south = __bind(this.south, this);
      this.north = __bind(this.north, this);
      this.move = __bind(this.move, this);
      this.travel = __bind(this.travel, this);
      this.app.on('north', this.north);
      this.app.on('south', this.south);
      this.app.on('east', this.east);
      this.app.on('west', this.west);
    }

    Movement.prototype.blocked = function(plot, label) {
      var current_plot;
      current_plot = plot.plot;
      switch (label) {
        case "north":
          return current_plot.north_wall || plot.north.south_wall;
        case "south":
          return current_plot.south_wall || plot.south.north_wall;
        case "east":
          return current_plot.east_wall || plot.east.west_wall;
        case "west":
          return current_plot.west_wall || plot.west.east_wall;
      }
    };

    Movement.prototype.travel = function(xmod, ymod, user) {
      var x, y;
      x = user.x + xmod;
      y = user.y + ymod;
      return this.app.trigger('getLocation', {
        x: x,
        y: y,
        fn: function(data) {
          this.app.trigger('printPlot', data);
          return this.app.trigger('updateUser', {
            x: x,
            y: y
          });
        }
      });
    };

    Movement.prototype.move = function(label, xmod, ymod) {
      var _this = this;
      return this.app.trigger('getUser', function(user) {
        return _this.app.trigger('getLocation', {
          x: user.x,
          y: user.y,
          fn: function(plot) {
            if (_this.blocked(plot, label)) {
              return _this.app.trigger('print', "The way to the " + label + " is barred!");
            } else {
              _this.app.trigger('print', "You travel " + label);
              return _this.travel(xmod, ymod, user);
            }
          }
        });
      });
    };

    Movement.prototype.north = function() {
      return this.move('north', 0, 1);
    };

    Movement.prototype.south = function() {
      return this.move('south', 0, -1);
    };

    Movement.prototype.east = function() {
      return this.move('east', 1, 0);
    };

    Movement.prototype.west = function() {
      return this.move('west', -1, 0);
    };

    return Movement;

  })();

}).call(this);
