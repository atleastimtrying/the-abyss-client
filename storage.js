// Generated by CoffeeScript 1.6.2
(function() {
  var LocalStorage, localStorage,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  LocalStorage = require('node-localstorage').LocalStorage;

  localStorage = new LocalStorage('./scratch');

  exports.Storage = (function() {
    function Storage(app) {
      this.app = app;
      this.createUser = __bind(this.createUser, this);
      this.getUser = __bind(this.getUser, this);
      this.establishUser = __bind(this.establishUser, this);
      this.app.on('getUser', this.getUser);
      this.app.on('updateUser', this.updateUser);
      this.app.on('establishUser', this.establishUser);
      if (!localStorage) {
        this.app.emit('print', 'you will need a modern browser with local storage to persist your game, we reccommend google chrome.');
      }
    }

    Storage.prototype.establishUser = function() {
      var _this = this;
      return this.app.emit('getUser', function(user) {
        if (user) {
          return _this.app.emit('getLocation', {
            x: user.x,
            y: user.y,
            fn: function(data) {
              return _this.app.emit('printPlot', data);
            }
          });
        } else {
          _this.createUser();
          return _this.app.emit('getLocation', {
            x: 0,
            y: 0,
            fn: function(data) {
              return _this.app.emit('printPlot', data);
            }
          });
        }
      });
    };

    Storage.prototype.getUser = function(fn) {
      return fn(JSON.parse(localStorage.getItem('abyssUser')));
    };

    Storage.prototype.createUser = function() {
      return this.updateUser(null, {
        x: 0,
        y: 0
      });
    };

    Storage.prototype.updateUser = function(options) {
      return localStorage.setItem('abyssUser', JSON.stringify(options));
    };

    return Storage;

  })();

}).call(this);