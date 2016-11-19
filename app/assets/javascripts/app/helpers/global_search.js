$(document).on('turbolinks:load', function() {
  $('form[data-global-search="true"]').on('submit',function (e) {
    e.preventDefault();

    var $this = $(this), $q = $this.find('[name="search[q]"]');
    var query = $.trim($q.val());

    // normalize all query empty spaces
    $q.val( query.replace(/\s+/g, " ") );

    var url = $this.attr('action') + '?' + $this.serialize();

    Turbolinks.visit(url);
  });
});
