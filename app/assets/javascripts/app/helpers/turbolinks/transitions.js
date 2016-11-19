$(function() {
  var _cache = {};

  function getContextKey() {
    var data = $('body').data();

    return data.controller + data.action;
  }

  function animate(el) {
    var $el = $(el);
    var animationType = $el.data('animateCss') || 'fadeIn';

    $(el).animateCSS(animationType);
  }

  function animateOnLoad(el) {
    var contextKey = getContextKey()

    var isFirstLoad = _cache[contextKey];

    if (!isFirstLoad) {
      _cache[contextKey] = true;

      animate(this);
    }
  }

  $(document).on('turbolinks:visit', function() {
    $('[data-animate-css]').each(function () {
      animate(this);
    });
  });

  $(document).on('turbolinks:load', function() {
    $('[data-animate-css]').each(function () {
      animateOnLoad(this);
    });
  });
});
