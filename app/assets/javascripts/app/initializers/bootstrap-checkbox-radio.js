(function() {
  $(document).on('turbolinks:load', function () {
    $('input[type="checkbox"]').each(function () {
      var $checkbox = $(this);
      $checkbox.checkbox();
    });
  });

  $(document).on('turbolinks:load', function () {
    $('input[type="radio"]').each(function () {
      var $radio = $(this);
      $radio.radio();
    });
  });
})();
