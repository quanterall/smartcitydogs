import "phoenix_html";
import $ from "jquery";
import "slick-carousel";

$(document).ready(function () {
    $('#close-map').click(function () {
        $('#map_container').hide();
    })
    $('.show-map-btn').click(function () {
        $('#map_container').show();
    });




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
        if (!is_mobile()) {
            if (event) {
                event.preventDefault();
            }
            if ($("#" + formId).is(":visible")) {
                $("#modal-forms-container").hide();
            } else {
                $(".modal-form").hide();
                $("#modal-forms-container").show();
                $("#" + formId).show();

            }
            console.log("asdasd");
        }
        return true

    };

   $('.status-btn').on('click', function(){
    $(".signal_change_type").css("display", "flex");
    $("#signal_id").text($(this).attr('id'))
    console.log($(this).attr('id') );
   });

   $('.close-btn').on("click", function(){
    $(".signal_change_type").css("display", "none");
   });

    window.is_mobile = function () {
        if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            return true;
        }
        return false
    };

    $('.close-modal').on('click', function (event) {
        event.preventDefault();
        $("#modal-forms-container").hide();
    });

    $(window).scroll(function (e) {
        if (window.location.pathname == '/') {
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
    $('.navbar-collapse').on('show.bs.collapse', function () {
        $(".top-navbar").removeClass("navbar-home");
    });
    $(".user-signals-tabs").click(function () {
        $('.tabs').hide();
        $(".user-signals-tabs").removeClass("selected");
        $(this).addClass("selected");
        $("#" + $(this).data("show")).show();

    });


    $('.signal-gallery').slick({
        slidesToShow: 2,
        slidesToScroll: 1,
        prevArrow: `<button class="slick-prev bg-gray border-0"><i class="fas fa-chevron-left"></i></button>`,
        nextArrow: `<button class="slick-next bg-green border-0 text-white"><i class="fas fa-chevron-right"></i></button>`,


    });

    $('#view_map').click(function () {
        var cor_a = $('#cor_a').val();
        var cor_b = $('#cor_b').val();
        console.log(cor_a + "Cor B: " + cor_b);
        var mymap = L.map('signal_map').setView([cor_a, cor_b], 16);

        L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
            maxZoom: 20,
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
            '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
            'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
            id: 'mapbox.streets'
        }).addTo(mymap);

        L.marker([cor_a, cor_b]).addTo(mymap);
    });

    
});
