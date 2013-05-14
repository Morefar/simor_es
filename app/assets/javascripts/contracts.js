(function() {
  jQuery(function() {
    $.datepicker.setDefaults({
      showOn: "button",
      buttonImageOnly: true,
      buttonImage: "/assets/calendar.png",
      regional: "es",
      changeMonth: true,
      changeYear: true,
      yearRange: "2000:2020",
      closeText: "Close",
      dateFormat: 'yy-mm-dd',
      duration: "slow",
      hideIfNoPrevNext: true
      });
    $('#contract_start_date').datepicker();
    $('#contract_first_canon_date').datepicker();
    $('#contract_expiration_date').datepicker();
    $('#contract_last_date_to_option').datepicker();
  });
}).call(this);


