$(document).ready(function() {


    fnhover();
        fnQuickMenu();
        fnCopyAddress();

});
function fnCopyAddress() {
        $('.copy_address').click(
            function() {
                var addressBox = document.getElementById('address');
                addressBox.select();
                document.execCommand('Copy');
                alert('주소가 복사 되었습니다.');
            }
        );
    }




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