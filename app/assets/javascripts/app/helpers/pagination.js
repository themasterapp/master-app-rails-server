$(function() {
  $(document).on("click",'.pagination a[data-remote=true]', function() {
    history.pushState({}, '', $(this).attr('href'));
  });
});
