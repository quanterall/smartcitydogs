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

//var x = document.getElementById("myText");
//console.log(x);
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