(function() {
  var android = this.android,
      webkit = this.webkit;

  var consoleHandler = {
    postMessage: function(data) {
      console.log("TurbolinksNativeMessageHandler.postMessage:", data);
    }
  };

  this.TurbolinksNativeMessageHandler = {
    _getDefaultNamespace: function() {
      var $container = $('[data-turbolinks-native-message-handler]');
      
      if ($container.length) {
        return $container.data()['turbolinksNativeMessageHandler'];
      }
    },
    
    _getNamespace: function(value) {
      if (value) {
        return value;
      } else {
        return this._getDefaultNamespace();
      }
    },

    postMessage: function(data, namespace) {
      var handler;

      // Android container
      if (android) {
        handler = android;

      // iOS container
      } else if (webkit && webkit.messageHandlers) {
        var _namespace = this._getNamespace(namespace);

        handler = webkit.messageHandlers[_namespace];

      } else {
        handler = consoleHandler;
      }

      handler.postMessage(data);
    }
  };
})();
