$(document).on('turbolinks:before-visit', function() {
  var $witch = $('[data-auto-navbar-collapse="true"]');

  if ($witch.length) {
    // Example of how to autoclose a regular bootstrap navbar.
    // $navbar.collapse('hide');

    // Autoclose the paper admin menu.
    var navStateClass = 'nav-open';
    var $html = $('html');

    if ( $html.hasClass(navStateClass) ) {
      $html.removeClass(navStateClass);
    }
  }
});
