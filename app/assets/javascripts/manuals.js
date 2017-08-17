// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

  $('a.toggle-filter').click(function(e){
    e.preventDefault();
    $('#filters').toggle();
    $('.fa-sitemap').toggleClass('selected');
  });

});
