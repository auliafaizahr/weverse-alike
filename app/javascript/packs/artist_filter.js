$(document).on('turbolinks:load', function(){
  $('input[name="date_filter"]').daterangepicker({
    opens: 'center'
  }, function(start, end, label) {
    console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
  });
  $('.choose_artist_filter').select2({width: '100%' });
});
