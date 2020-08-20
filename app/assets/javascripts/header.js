$(document).on('turbolinks:load', function(){
  $("#show-sidebar").click(function(e) {
    e.preventDefault();
    $(".page-wrapper").addClass("toggled");
  });
  $("#close-sidebar").click(function(e) {
    e.preventDefault();
    $(".page-wrapper").removeClass("toggled");
  });
});