$(document).on('turbolinks:load', function(){
  $('#toggle_sidebar').click(function() {
    $("#sidebar_toggle_menu").toggleClass("collapsed_active");
  })
});



