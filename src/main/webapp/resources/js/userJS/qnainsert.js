onload = function() {
   $(document).ready(function() {
      fnhover();
      fnQuickMenu();
   
   });
   
   function fnQuickMenu() {
      var currentPosition = parseInt($(".quickmenu").css("top"));
      $(window).scroll(function() {
         var position = $(window).scrollTop();
         $(".quickmenu").stop().animate({
               "top": position + currentPosition + "px"
         }, 1000);
      });
   
   }
   
   function fnhover() {
      (function($) {
         $('.cate ul').hide();
         $('.cate .menu .subopen').click(function() {
               if ($(this).hasClass('active')) {
                  $(this).parent().next().slideUp('slow');
                  $(this).removeClass('active');
               } else {
                  $('.accordion').find('.active').parent().next().slideUp('slow');
                  $('.accordion').find('.active').removeClass('active');
                  $(this).parent().next().slideDown('slow');
                  $(this).addClass('active');
               }
         });
      })(jQuery);
   }

}
