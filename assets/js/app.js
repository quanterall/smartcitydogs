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
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

////////////ORIGINAL//////////////



// $(".form-elixir").submit(function(event){
//     event.preventDefault(); //prevent default action 
//     var post_url = $(this).attr("action"); //get form action url
//     var request_method = $(this).attr("POST"); //get form GET/POST method
//     var form_data = $(this).serialize(); //Encode form elements for submission
//     $.ajax({
//         url : post_url,
//         type: request_method
//         // data : form_data
//     }).done(function(response){
//         console.log(form_data);
//         console.log(response);
// 		alert("Success!") 
//     }).error(function(error){
// 		alert("ERROR!")
//         //tuk izpisvash error
        
// 	});
// });


$("#like").click(function() {

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
});


$("#comment").click(function() {

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

window.onload = function() {
    $('.Signals').html('<ul style="list-style-type:none;">  <li class="title_filter"> Филтрирай по категория </li> ' +
    '<li class="ul_filter"> <input  id="sig_category" name="check[sig_category]" type="checkbox" > Бездомно куче </li>'+  
    '<li class="ul_filter"> <input  id="sig_category" name="check[sig_category]" type="checkbox" > Избягал домашен любимец </li>'+
    '<li class="ul_filter"> <input  id="sig_category" name="check[sig_category]" type="checkbox" > Малтретиране на животно </li>'+
    ' </ul> <ul style="list-style-type:none;">  <li class="title_filter"> Филтрирай спрямо Статус </li> ' +
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Нов </li>'+  
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Приет </li> '+
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Изпратен </li>'+
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Приключен </li>'+
    ' </ul>');
    $('.Signals1').html('');
    $('.Signals2').html('');
    $('.Signals3').html('');
}


$(function() {


    //---------------nav-bar all signals-----------
    // $('#signals_all_nav').on('click', function(){
    //     $('.Signals').html('<ul>  <li> Филтрирай по категория </li> ' +
    //                                 '<li>  </li>'+
    //                                 ''+
    //                                 ' </ul>');
    //     $('.Signals1').html('');
    //     $('.Signals2').html('');
    //     $('.Signals3').html('');
    // })

    //-----------------new signal -------------
  // $('#send-signal').on('click', function() {
  //   $('.send-signal-container').load('signals/new');
  // })

  //-----------------all signals----------------
  $('#all-signals').on('click', function() {
    $('.container-signals').load('signals/filter_index');
    $('.Signals').html('<ul style="list-style-type:none;">  <li class="title_filter"> Филтрирай по категория </li> ' +
    '<li class="ul_filter"> <input  id="sig_category" name="check[sig_category]" type="checkbox" > Бездомно куче </li>'+  
    '<li class="ul_filter"> <input  id="sig_category" name="check[sig_category]" type="checkbox" > Избягал домашен любимец </li>'+
    '<li class="ul_filter"> <input  id="sig_category" name="check[sig_category]" type="checkbox" > Малтретиране на животно </li>'+
    ' </ul> <ul style="list-style-type:none;">  <li class="title_filter"> Филтрирай спрямо Статус </li> ' +
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Нов </li>'+  
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Приет </li> '+
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Изпратен </li>'+
    '<li class="ul_filter"> <input  id="sig_status" name="check[sig_status]" type="checkbox" > Приключен </li>'+
    ' </ul>');
    $('.Signals1').html('');
    $('.Signals2').html('');
    $('.Signals3').html('');
  });

  // ------------------Registered dogs----------------
  $('#all-registered-dogs').on('click', function() {
    $('.container-signals').load('animals');
    $('.Signals').html('');
    $('.Signals1').html('<ul style="list-style-type:none;">  <li class="title_filter"> Филтрирай спрямо Статус </li> ' +
    '<li class="ul_filter"> <input  id="animal_status_chBox" name="check[animal_status_chBox]" type="checkbox" > На свобода </li>'+  
    '<li class="ul_filter"> <input  id="animal_status_chBox" name="check[animal_status_chBox]" type="checkbox" > В приют </li>'+
    '<li class="ul_filter"> <input  id="animal_status_chBox" name="check[animal_status_chBox]" type="checkbox" > Осиновено </li> </ul> ');
    $('.Signals2').html('');
    $('.Signals3').html('');

  });

  //-----------------Adopted dogs-----------------
   $('#all-adopted-dogs').on('click', function() {
    $('.container-signals').load('signals/adopted_animals');
    $('.Signals').html('');
    $('.Signals1').html('');

   });

  // -------------Dogs under shelter----------------
   $('#all-dogs-shelter').on('click', function() {
     $('.container-signals').load('signals/shelter_animals');
     $('.Signals').html('');
     $('.Signals1').html('');
   });

   

});


$(document).ready(function(){
  $('input[type="checkbox"]').click(function(){
      if($(this).is(":checked")){
          alert("Checkbox is checked.");
      }
      else if($(this).is(":not(:checked)")){
          alert("Checkbox is unchecked.");
      }
  });
});



$(function(){

  var modal = document.getElementById('myModal-signal');
  var span = document.getElementsByClassName("close1")[0];

  window.onload = function(){
    $('body').css("position","auto");
  }

  $('#send-signal').on('click', function(){
    // $('.send-signal-contaier').load('signals/new');
    $('main').css("position","fixed");
    $('main').css("width","100%");
    $('.modal-content-signal').load('signals/new');
    // $('.navbar-dark.top-navbar').css("box-shadow","0px 9px 8px -5px rgba(0, 0, 0, 0.75)");
    modal.style.display = "block";
  });

  $('#nav-register').on('click', function(){
    // $('.send-signal-contaier').load('signals/new');
    $('main').css("position","fixed");
    $('main').css("width","100%");
    $('.modal-content-signal').load('users/new');


    modal.style.display = "block";
  });

  $('#nav-sign-in').on('click', function(){
    // $('.send-signal-contaier').load('signals/new');
    $('main').css("position","fixed");
    $('main').css("width","100%");
    $('.modal-content-signal').load('sessions/new');


    modal.style.display = "block";
  });

  $('#forgotten-password').on('click', function(){
    // $('.send-signal-contaier').load('signals/new');
    $('main').css("position","fixed");
    $('main').css("width","100%");
    $('.modal-content-signal').load('forgoten_password/new');


    modal.style.display = "block";
  });


  span.onclick = function() {
      modal.style.display = "none";

      $('main').css("position","initial");
    //   $('.navbar-dark.top-navbar').css("box-shadow","none");

  }


});

$(function(){

  var modal = document.getElementById('myModal');
  var span = document.getElementsByClassName("close")[0];
  var id;
  var SelectedType;

  $('.change-status').on('click',function() {
    id = $(this).attr('id');
    console.log("Buttton: "+id);
    modal.style.display = "block";

  });
  span.onclick = function() {
      modal.style.display = "none";
  }
  window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
  }
  $('#type-chosen').on('click',function(){

    SelectedType = $(".select-type option:selected").val()
    console.log(SelectedType);
    console.log("Buttton1: "+id);

    $.ajax({
        method: "GET",
        url: "/signals/update_type",
        data: {
            "id": id,
            "signals_types_id": SelectedType
        }
     })



     setTimeout(function() {
        //  location.reload()
         window.location.href = '/signals';
     }, 1000);


  });
});
