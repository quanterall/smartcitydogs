// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";
import "slick-carousel";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

////////////ORIGINAL//////////////


$("#like").click(function () {

    $.ajax({
        method: "GET",
        url: "/signals/update_like_count",
        data: {
            "show-count": $("#signal-count").text(),
            "show-id": $("#signal-id").text()
        }
    }).then(function (data) {
        $("#signal-count").text(data.new_count);

    })
});

$('.close2').click(function() {
    $('#show_map').hide();
    $('.close2').hide();

})
$('#show-map').click(function() {
    $('#show_map').show();
    $('.close2').show();
    // $('body').css("p","");
    
    
})

$('#submit-like1').on('click',function(){
    var a = $('#submit-like1').text();
    console.log(a);
  if(a == "ПОСЛЕДВАЙ"){
    $.ajax({
        method: "GET",
        url: "/signals/update_like_count",
        data: {
            "show-count": $("#signal-count").text(),
            "show-id": $("#signal-id").text()
        }
    }).then(function(data) {
        $("#signal-count").text(data.new_count);

    })

    $('#submit-like1').text("ОТСЛЕДВАЙ");
  }
 else{
    $.ajax({
        method: "GET",
        url: "/signals/remove_like",
        data: {
            "show-count": $("#signal-count").text(),
            "show-id": $("#signal-id").text()
        }
    }).then(function(data) {
        $("#signal-count").text(data.new_count);

    })
    $('#submit-like1').text("ПОСЛЕДВАЙ");
  }
});

$('#comment').click(function() {
    
    $('#comment').hide();
    $('.comment_section').show();
});

$('.close_comment').click(function() {
    
    $('#comment').show();
    $('.comment_section').hide();
});


$(".submit_comment").click(function() {

    $.ajax({
        method: "GET",
        url: "/signals/comment",
        data: {
            "show-comment": $("#comment-id").val(),
            "show-id": $("#signal-id").text()
        }
    }).then(function(data) {
        $("#comment-id").val("");
    })
});


window.login = function () {
    var params = {email: $("#login-email").val(), password: $("#login-password").val()};
    $.post("/api/users/sign_in", params)
        .done(function (data) {
            if ((data.users_types_id == 4) || (data.users_types_id == 5)) {
                window.location.href = "index_home_minicipality";
            }
            else {
                location.reload();
            }
        })
        .fail(function (text) {
            $("#login-form-errors").text("Невалиден Имейл или Парола!!!!");
        });

};


$('.slick').slick({
    slidesToShow: 4,
    slidesToScroll: 1,
    prevArrow: `<button class="slick-prev bg-gray border-0"><i class="fas fa-chevron-left"></i></button>`,
    nextArrow: `<button class="slick-next bg-green border-0 text-white"><i class="fas fa-chevron-right"></i></button>`,
    responsive: [
        {
            breakpoint: 1200,
            settings: {
                slidesToShow: 4,
                slidesToScroll: 1,
                infinite: true,
            }
        },
        {
            breakpoint: 1024,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 1,
                infinite: true,
            }
        },
        {
            breakpoint: 800,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 2,
                infinite: true,
            }
        },
        {
            breakpoint: 480,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1,
                infinite: true,
            }
        }
    ]
});

window.showModalForm = function (event, formId) {
    event.preventDefault();
    if ($("#" + formId).is(":visible")) {
        $("#modal-forms-container" ).hide();
    } else {
        $(".modal-form").hide();
        $("#modal-forms-container" ).show();
        $("#" + formId).show();

    }
};
$('.close-modal').on('click', function (event) {
    event.preventDefault();
    $("#modal-forms-container" ).hide();
});

$(window).scroll(function(e){
    if ( window.location.pathname == '/' ) {
        if ($(document).scrollTop() == 0) {
            $(".top-navbar").addClass("navbar-home");
            $("#top-navbar-container").removeClass("bg-white");
        } else {
            $(".top-navbar").removeClass("navbar-home");
            $("#top-navbar-container").addClass("bg-white");
        }
    }
});
$('.navbar-collapse').on('show.bs.collapse', function() {
    $(".top-navbar").removeClass("navbar-home");
});


    