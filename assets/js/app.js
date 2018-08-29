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

function myOnLoadCallback() {
    alert("Captcha is OK");
  }


$('#submit-adoption').click(function(){
    
    $.ajax({
        method: "POST",
        url: "/api/animals/:id/send_email",
        credentials: 'same-origin',
        data: {
            "chip_number": $("#chip_number").text(),
            "user_name": $("#user_name").text(),
            "user_last_name": $("#user_last_name").text(),
            "user_email": $("#user_email").text(),
            "user_phone": $("#user_phone").text(),
            "animal_id": $("#animal_id").text(),
            "user_id": $("#user_id").text()
        },
        success: function (msg) {
                alert("Имейлът ви беше успешно изпратен!");
        },
        error: function (xhr, status) {
           alert("ГРЕШКА!");
          }
    
    }).done(function(){
		location.reload();
	})
});

$('#submit-news').click(function(){
    var editor_content = quill.container.firstChild.innerHTML
    var image = document.getElementById('image').value
    var title = document.getElementById('title').value
    var short_content = document.getElementById('short_content').value
    $.ajax({
        method: "POST",
        url: "/news",
        credentials: 'same-origin',
        data: {
            "news": {
                    "image_url": image,
                    "title": title,
                    "short_content": short_content,
                    "content": editor_content,
                    }
        },
        success: function (msg) {
                alert("Новината ви беше успешно създадена!");
        },
        error: function (xhr, status) {
           alert("Неуспешно създаване на новина!");
          }
    }).done(function(){
		location.reload();
	})
});

$("#my-signals-link").click(function(){
    $(".last-signals-dogs-div").css("display","inline-block");
    $(".last-signals-dogs-div2").css("display","none");
})
$("#followed-signals-link").click(function(){
    $(".last-signals-dogs-div").css("display","none");
    $(".last-signals-dogs-div2").css("display","inline-block");

})

$("#like").click(function () {

    $.ajax({
        method: "GET",
        url: "/api/signals/"+$("#signal-id").text()+"/like"
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

  if(a == "ПОСЛЕДВАЙ"){
    $.ajax({
        method: "GET",
        url: "/api/signals/"+$("#signal-id").text()+"/like",
    }).then(function(data) {
        console.log(data);
        $("#signal-count").text(data.new_count);
    })

    $('#submit-like1').text("ОТСЛЕДВАЙ");
  }
 else{
    $.ajax({
        method: "GET",
        url: "/api/signals/"+$("#signal-id").text()+"/unlike",
    }).then(function(data) {
        console.log(data);
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
        url: "/api/signals/:id/comment",
        data: {
            "show-comment": $("#comment-id").val(),
            "show-id": $("#signal-id").text()
        }
    }).done(function(){
		location.reload();
    })
});


window.login = function () {
    var params = {email: $("#login-email").val(), password: $("#login-password").val()};
    $.post("/api/users/sign_in", params)
        .done(function (data) {
            if ((data.users_types_id == 4) || (data.users_types_id == 5)) {
                window.location.href = "municipality/signals";
            }
            else {
                location.reload();
            }
        })
        .fail(function (text) {
            $("#login-form-errors").text("Невалиден Имейл или Парола!");
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
            $(".modal-form").addClass("shadow-off");
            $(".container-new-signal").addClass("shadow-off");
            $("#top-navbar-container").removeClass("bg-white");
        } else {
            $(".modal-form").removeClass("shadow-off");
            $(".container-new-signal").removeClass("shadow-off");
            $(".container-new-signal").addClass("shadow-on");
            $(".top-navbar").removeClass("navbar-home");
            $("#top-navbar-container").addClass("bg-white");
        }
    }
});
$('.navbar-collapse').on('show.bs.collapse', function() {
    $(".top-navbar").removeClass("navbar-home");
});


    


