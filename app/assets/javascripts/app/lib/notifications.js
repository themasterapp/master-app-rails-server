(function() {
  var DATA_DISABLE = 'data-disable',
      NOTIFICATIONS = {
        timeout: 2000,
        alert: {
          state: 'danger',
          icon: 'ti-thumb-down'
        },
        notice: {
          state: 'success',
          icon: 'ti-thumb-up'
        }
      };

  function notifyWith(flashType, message) {
    var notification = NOTIFICATIONS[flashType];

    $.notify({
      icon: notification['icon'],
      message: message
    },{
        type: notification['state'],
        timer: NOTIFICATIONS['timeout']
    });
  }

  function notifyIfEnable(data) {
    if (data && !data['disable']) {
      notifyWith(data['type'], data['text']);
    }
  }

  function notifyWithElement(el) {
    var $el = $(el), data = $.extend(
      { disable: $el.attr(DATA_DISABLE) },
      $el.data()
    );

    notifyIfEnable(data);

    return $el;
  }

  this.RailsFlashMessagesAsNotifications = {
    showAll: function() {
      $('#flash-messages li').each(function(i, el) {
        notifyWithElement(el).attr(
          DATA_DISABLE, "true"
        );
      });
    },

    alert: function(message) {
      notifyWith('alert', message);
    },

    notice: function(message) {
      notifyWith('notice', message);
    }
  };

  // Application Layout > ul.hidden#flash-messages wrapper.
  $(document).on("turbolinks:load", RailsFlashMessagesAsNotifications.showAll);
})(this);
