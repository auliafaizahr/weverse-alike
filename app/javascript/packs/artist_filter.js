$(document).on('turbolinks:load', function(){
  $('input[name="date_filter"]').daterangepicker({
    opens: 'center',
    autoUpdateInput: false,
    locale: {
        cancelLabel: 'Clear'
    }
  }, function(start, end, label) {
    console.log("A new date selection was made: " + start.format('DD-MM-YYYY') + ' to ' + end.format('DD-MM-YYYY'));
  });
  $('#choose_date').select2({width: '100%' });

  $('.choose_artist_filter').select2({
    width: '100%',
    allowClear: true,
    placeholder: "Choose Artist"
  });
});
