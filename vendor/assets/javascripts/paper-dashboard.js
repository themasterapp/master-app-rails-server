(function() {
  var navbar_initialized;

  $(document).on("turbolinks:load", function(){
    navbar_initialized = false;

    var window_width = $(window).width();

    // Init navigation toggle for small screens
    if(window_width <= 991){
      lbd.initRightMenu();
    }

    //  Activate the tooltips
    $('[rel="tooltip"]').tooltip();

  });

  // activate collapse right menu when the windows is resized
  $(window).resize(function(){
    if($(window).width() <= 991){
      lbd.initRightMenu();
    }
  });

  var lbd = {
    initRightMenu: function(){
      var $sidebar = $('.sidebar');

      if($sidebar.length && !navbar_initialized){
        var $off_canvas_sidebar = $('nav').find('.navbar-collapse').first().clone(true);

        var sidebar_bg_color = $sidebar.data('background-color');
        var sidebar_active_color = $sidebar.data('active-color');

        var $logo = $sidebar.find('.logo').first();
        var logo_content = $logo[0].outerHTML;

        var ul_content = '';

        // set the bg color and active color from the default sidebar to the off canvas sidebar;
        $off_canvas_sidebar.attr('data-background-color',sidebar_bg_color);
        $off_canvas_sidebar.attr('data-active-color',sidebar_active_color);

        $off_canvas_sidebar.addClass('off-canvas-sidebar');

        //add the content from the regular header to the right menu
        $off_canvas_sidebar.children('ul').each(function(){
          content_buff = $(this).html();
          ul_content = ul_content + content_buff;
        });

        // add the content from the sidebar to the right menu
        var content_buff = $sidebar.find('.nav').html();
        var ul_content = ul_content + '<li class="divider"></li>'+ content_buff;

        var ul_content = '<ul class="nav navbar-nav">' + ul_content + '</ul>';

        var navbar_content = logo_content + ul_content;
        var navbar_content = '<div class="sidebar-wrapper">' + navbar_content + '</div>';

        $off_canvas_sidebar.html(navbar_content);

        $('body').append($off_canvas_sidebar);

        var $toggle = $('.navbar-toggle');

        $off_canvas_sidebar.find('a').removeClass('btn btn-round btn-default');
        $off_canvas_sidebar.find('button').removeClass('btn-round btn-fill btn-info btn-primary btn-success btn-danger btn-warning btn-neutral');
        $off_canvas_sidebar.find('button').addClass('btn-simple btn-block');

        $toggle.click(function (){
          var NAV_OPEN = 'nav-open',
              BODY_CLICK = 'bodyClick';

          var $html = $('html');

          var handleCloseSidebar = function() {
            $html.removeClass(NAV_OPEN);

            $('#' + BODY_CLICK).remove();

            setTimeout(function(){
              $toggle.removeClass('toggled');
            }, 400);
          }

          if($html.hasClass(NAV_OPEN)) {
            handleCloseSidebar();
          } else {
            setTimeout(function(){
              $toggle.addClass('toggled');
            }, 430);

            var BODY_CLICK_DIV = '<div id="' + BODY_CLICK + '"></div>';

            $(BODY_CLICK_DIV).appendTo("body").click(handleCloseSidebar);

            $html.addClass(NAV_OPEN);
          }
        });
        navbar_initialized = true;
      }
    }
  }
})();
