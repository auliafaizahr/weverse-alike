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

  $('input[name="date_filter"]').on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
  });

  $('input[name="date_filter"]').on('cancel.daterangepicker', function(ev, picker) {
      $(this).val('');
  });

  $('#choose_date').select2({width: '100%' });
  $('.choose_artist_filter').select2({
    width: '100%',
    allowClear: true,
    placeholder: "Choose Artist"
  });

  $('.choose_sort').select2({
    allowClear: true,
    placeholder: "Sort by",
    width: '50%'
  });
});


