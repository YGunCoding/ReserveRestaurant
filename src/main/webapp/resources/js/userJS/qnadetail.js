    
    $(document).ready(function(){
    
    
		fnhover();
		fnQuickMenu();
    
    
    
    	// 수정
    	$('#update_btn').on('click', function(){
    		if ('${qnaBoardDetail.qnaTitle}' == $('#qnaTitle').val() && 
    			'${qnaBoardDetail.qnaContent}' == $('#qnaContent').val()) {
    			 alert('수정할 내용이 없다.');
    			 return;
    		}
    		$('#f').attr('action', 'updateBoardQna');
    		$('#f').submit();
    	});
    	
        // 삭제
        $('#delete_btn').on('click', function(){
    		if (confirm('삭제할까요?')) {
    			$('#f').attr('action', 'deleteBoardQna');
        		$('#f').submit();
    		}
    	});
    	
    });
    
    
    
    
    
function fnhover() {
 //(function($) {
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
}
// });(jQuery);

function fnQuickMenu() {
     var currentPosition = parseInt($(".quickmenu").css("top"));
     $(window).scroll(function() {
        var position = $(window).scrollTop();
        $(".quickmenu").stop().animate({
              "top": position + currentPosition + "px"
        }, 1000);
     });
  
  }