(function() {
  jQuery(function() {
    $.datepicker.setDefaults({
      // showOn: "button",
      // buttonImageOnly: true,
      // buttonImage: "/assets/calendar.png",
      regional: "es",
      changeMonth: true,
      changeYear: true,
      yearRange: "2000:2020",
      closeText: "Close",
      dateFormat: 'yy-mm-dd',
      duration: "slow",
      hideIfNoPrevNext: true
      });
    $('.date-field').datepicker();
  });
}).call(this);


