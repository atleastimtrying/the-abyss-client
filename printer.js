// Generated by CoffeeScript 1.6.2
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  exports.Printer = (function() {
    function Printer(app) {
      this.app = app;
      this.printPlot = __bind(this.printPlot, this);
      this.app.on('print', this.print);
      this.app.on('printPlot', this.printPlot);
    }

    Printer.prototype.print = function(message) {
      return console.log(message + '\n');
    };

    Printer.prototype.getDirections = function(plot) {
      var direction;
      direction = "";
      if (!(plot.plot.north_wall || plot.north.south_wall)) {
        direction += "<span class=\"highlight\">north</span> lies " + plot.north.title + "<br>";
      }
      if (!(plot.plot.south_wall || plot.south.north_wall)) {
        direction += "<span class=\"highlight\">south</span> lies " + plot.south.title + "<br>";
      }
      if (!(plot.plot.east_wall || plot.east.west_wall)) {
        direction += "<span class=\"highlight\">east</span> lies " + plot.east.title + "<br>";
      }
      if (!(plot.plot.west_wall || plot.west.east_wall)) {
        direction += "<span class=\"highlight\">west</span> lies " + plot.west.title + "<br>";
      }
      return direction;
    };

    Printer.prototype.printPlot = function(plot) {
      this.print('<h2>' + plot.plot.title + '</h2>');
      this.print(plot.plot.description);
      return this.print(this.getDirections(plot));
    };

    return Printer;

  })();

}).call(this);
