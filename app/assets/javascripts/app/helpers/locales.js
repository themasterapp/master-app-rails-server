$(document).on('turbolinks:load', function() {
  $("a[data-locale=true]").on("click", function (e) {
    e.preventDefault();

    $(document).one("turbolinks:render", function() {
      Turbolinks.clearCache();
    });

    var url = $(this).attr('href');

    Turbolinks.visit(url, "replace");
  });
});
