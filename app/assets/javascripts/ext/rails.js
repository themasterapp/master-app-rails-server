/*
  Based on
  http://thehungrycoder.com/ruby-on-rails/replace-rails-confirm-dialog-with-bootboxjs.html
*/

$(function() {
  var ConfirmToDestroy = {};

  var centralize = function(box) {
    // https://github.com/makeusabrew/bootbox/issues/166
    box.css({
      'top': '50%',
      'margin-top': function () {
        return -(box.height() / 2);
      }
    });
  };
  
  ConfirmToDestroy.customDialog = function(message, confirmMSG, cancelMSG, callback) {
    var box = bootbox.confirm({
      message: message,
      callback: callback,
      buttons: {
        confirm: {
          label: (confirmMSG || 'Yes, definitely!'),
          className: 'btn-danger btn-fill'
        },
        cancel: {
          label: (cancelMSG || 'Opss! No.'),
          className: 'btn-fill'
        }
      }
    });
    
    centralize(box);
  };
  
  ConfirmToDestroy.dialog = function(message, callback) {
    ConfirmToDestroy.customDialog(message, false, false, callback);
  };
  
  var railsCallbackHandler = function(callback) {
    return function (result) {
      if (typeof callback === 'function') {
        if (result) {
          return callback();
        }
      }
    }
  };
  
  ConfirmToDestroy.railsDialog = function(message, confirmMSG, cancelMSG, callback) {
    var handler = railsCallbackHandler(callback);
    
    if (!confirmMSG || !cancelMSG) {
      ConfirmToDestroy.dialog(message, handler);
    } else {
      ConfirmToDestroy.customDialog(message, confirmMSG, cancelMSG, handler);
    }
  };
  
  $(document).on('turbolinks:load', function() {
    $('[data-destroy="action"]').on('click', function(e) {
      e.preventDefault();
      
      var $this = $(this);
      var data, message, confirmButton, cancelButton;
      
      data = $this.data();
      
      message = data['confirmMsg'];
      cancelButton = data['cancelBtn'];
      confirmButton = data['confirmBtn'];
      
      ConfirmToDestroy.customDialog(message, confirmButton, cancelButton,
        function(result) {
          if(result) {
            $.ajax({url: $this.attr('href'), type: 'DELETE'});
          }
        }
      );
    });
  });

  $.rails.allowAction = function(element) {
    var answer, callback, message, cancelMSG, confirmMSG;

    message = element.data('confirm');
    cancelMSG = element.data('cancelBtn');
    confirmMSG = element.data('confirmBtn');

    if (!message) {
      return true;
    }

    answer = false;
    callback = void 0;

    if ($.rails.fire(element, 'confirm')) {
      ConfirmToDestroy.railsDialog(message, confirmMSG, cancelMSG, function() {
        var oldAllowAction;

        callback = $.rails.fire(element, 'confirm:complete', [answer]);

        if (callback) {
          oldAllowAction = $.rails.allowAction;

          $.rails.allowAction = function() {
            return true;
          };

          element.trigger('click');
          return $.rails.allowAction = oldAllowAction;
        }
      });
    }

    return false;
  };
});
