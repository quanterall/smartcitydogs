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

// console.log("test");
// $("#like").click(function(){
//
//   $.ajax({
//     method: "GET",
//     url: "/signals/something_else",
//     data: {"show-count": $("#signal-id").text()}
//   }).then(function(data) {
//     $("#signal-id").text(data.new_count);
//   })
// });

//console.log("test");
//var a=$(".btnSignal");
//console.log(a);
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

$(function() {

  //-----------------all signals----------------
  $('#all-signals').on('click', function() {
    $('.container-signals').load('signals/filter_index');
  });

  // ------------------Registered dogs----------------
  $('#all-registered-dogs').on('click', function() {
    $('.container-signals').load('animals');
  });

  //-----------------Adopted dogs-----------------
   $('#all-adopted-dogs').on('click', function() {
    $('.container-signals').load('signals/adopted_animals');
   });

  // -------------Dogs under shelter----------------
   $('#all-dogs-shelter').on('click', function() {
     $('.container-signals').load('signals/shelter_animals');
   });
});

$(function(){
  // var modal = document.getElementById('myModal');
  // var btn = document.getElementById("button-change-status");
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
    // var SelectedType = $('.select-type').find(":selected").text();
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

    // modal.style.display ="none";

     setTimeout(function () {
        //  location.reload()
         window.location.href = '/signals';
     }, 1000);
//     var form = new FormData();
// form.append("email", "sonyft@abv.bg");
// form.append("password", "123456");

// var settings = {
//   "async": true,
//   "crossDomain": true,
//   "url": "http://localhost:4000/api/users/sign_in",
//   "method": "POST",
//   "headers": {
//     "Cache-Control": "no-cache",
//     "Postman-Token": "2a5b4054-16ab-4ec9-b532-e4ba555cc523"
//   },
//   "processData": false,
//   "contentType": false,
//   "mimeType": "multipart/form-data",
//   "data": form
// }

// $.ajax(settings).done(function (response) {
//   console.log(response);
// });

//     var settings = {
//   "async": true,
//   "crossDomain": true,
//   "url": "http://localhost:4000/api/signals/"+id,
//   "method": "PUT",
//   "headers": {
//     "Content-Type": "application/x-www-form-urlencoded",
//     "Cache-Control": "no-cache",
//     "Postman-Token": "901b1893-aa01-40df-8975-c3ac6299e525"
//   },
//   "data": {
//     "signal[signals_types_id]": SelectedType
//   }
// }
//     console.log(settings);
// $.ajax(settings).done(function (response) {
//   console.log("Response " + response);
// });

// var form1 = new FormData();
// form1.append("id", "2");

// var settings = {
//   "async": true,
//   "crossDomain": true,
//   "url": "http://localhost:4000/api/users/logout",
//   "method": "POST",
//   "headers": {
//     "Cache-Control": "no-cache",
//     "Postman-Token": "ab1b1027-6704-4157-9f56-2889b45ec5dc"
//   },
//   "processData": false,
//   "contentType": false,
//   "mimeType": "multipart/form-data",
//   "data": form
// }

// $.ajax(settings).done(function (response) {
//   console.log(response);
// });

  });
});

// $(function(){
//   $('#type-chosen').on('click',function(){
//     // var SelectedType = $('.select-type').find(":selected").text();
//     var SelectedType = $(".select-type option:selected").val()
//     console.log(SelectedType);
//     console.log("Buttton1: "+id);
//
//   });
// });
