
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

$(document).ready(function(){
		fninsertPage();
	});
	
	function fninsertPage() {
		$('#qnaIn').click(function(){
			location.href="/restaurant/qnaboard/qnainsert";
		});
	}
      /* 게시판 */
      $(document).ready(function() {
         var activeSystemClass = $('.list-group-item.active');

         //something is entered in search form
         $('#system-search').keyup( function() {
            var that = this;
            // affect all table rows on in systems table
            var tableBody = $('.table-list-search tbody');
            var tableRowsClass = $('.table-list-search tbody tr');
            $('.search-sf').remove();
            tableRowsClass.each( function(i, val) {
            
               //Lower text for case insensitive
               var rowText = $(val).text().toLowerCase();
               var inputText = $(that).val().toLowerCase();
               if(inputText != '')
               {
                     $('.search-query-sf').remove();
                     tableBody.prepend('<tr class="search-query-sf"><td colspan="6"><strong>Searching for: "'
                        + $(that).val()
                        + '"</strong></td></tr>');
               }
               else
               {
                     $('.search-query-sf').remove();
               }

               if( rowText.indexOf( inputText ) == -1 )
               {
                     //hide rows
                     tableRowsClass.eq(i).hide();
                     
               }
               else
               {
                     $('.search-sf').remove();
                     tableRowsClass.eq(i).show();
               }
            });
            //all tr elements are hidden
            if(tableRowsClass.children(':visible').length == 0)
            {
               tableBody.append('<tr class="search-sf"><td class="text-muted" colspan="6">No entries found.</td></tr>');
            }
         });
      });

      
               /* 작성하기 */

               $(document).ready(function(){
                  function typeWriter(text, n) {
               if (n < (text.length)) {
               $('.test').html(text.substring(0, n+1));
               n++;
               setTimeout(function() {
               typeWriter(text, n)
               }, 100);
               }
               }

               $('.start').click(function(e) {
               e.stopPropagation();

               var text = $('.test').data('text');

               typeWriter(text, 0);
               });

               });
               $(document).ready(function(){
                  $(".que-list>li").css({"display": "none"});
                     $(".start").click(function(){
                     $(".que-list>li").fadeIn(800);
                        $(this).siblings('button').hide();               
                        $(".start").animate({marginLeft: "+=150px", marginTop: "-=100px"});
                        $(".start").css({"position": "fixed", top: "200px"});
                  });
               
               }); 	
                  