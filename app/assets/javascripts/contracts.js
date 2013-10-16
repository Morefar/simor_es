// Date Picker behavior.
(function() {
  $(function() {
    $.datepicker.setDefaults({
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

//Comment form behavior.
$('#new-comment-button').on('click', displayCommentForm);
function displayCommentForm() {
  var hiddenCommentBox = $('.new_comment');
  $(this).hide('fast');
  hiddenCommentBox.show('slow');
  hiddenCommentBox.find('textarea').focus();
};

// Toggle disable when option is checked.
$("#contract_option_to_buy").change(function() {
    var $input = $(this);
    var $datefield = $('#contract_last_date_to_option');
    if ($input.prop('checked')){
      $datefield.prop('disabled', false);
    } else {
      $datefield.prop('disabled', true)
    }
}).change();

// Date handling functions
Date.isLeapYear = function (year) {
  return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0));
};

Date.getDaysInMonth = function (year, month) {
  return [31, (Date.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
};

Date.prototype.isLeapYear = function () {
  var y = this.getFullYear();
  return (((y % 4 === 0) && (y % 100 !== 0)) || (y % 400 === 0));
};

Date.prototype.getDaysInMonth = function () {
  return Date.getDaysInMonth(this.getFullYear(), this.getMonth());
};

Date.prototype.addMonths = function (value) {
  var n = this.getDate();
  this.setDate(1);
  this.setMonth(this.getMonth() + value);
  this.setDate(Math.min(n, this.getDaysInMonth()));
  return this;
};

var updateExpirationField = function(){
  var $duration = parseInt($('#contract_duration').val());
  var $periods = parseInt($('#contract_periodicity').val());
  var $startDate = new Date($('#contract_first_canon_date').val());
  var $months = ($duration * $periods);
  $startDate.addMonths($months);
  $('#contract_expiration_date').val($startDate.getFullYear()+'-'+($startDate.getMonth()+1)+'-'+$startDate.getDate());
};

// Update expiration date based on first canon date and number of periods.
$('#contract_periodicity').change(function() {updateExpirationField()});
$('#contract_duration').change(function() {updateExpirationField()});

// Autocomplete behaviour for the asset form.
$('#asset_contract_number').autocomplete({
    source: $('#asset_contract_number').data('autocomplete-source'),
    minLength: 4,
});
$('#asset_contract_number').on("autocompleteclose",
    function( event, ui ){
        var selectedContractNumber = $(this).val();
        $.get("/es/contracts.json",
            { number: selectedContractNumber },
            function( data ) {
              $.get("/es/contracts/" + data + ".js");
            },
            "json"
        );
    });
$('#asset_make_name').autocomplete({source: $('#asset_make_name').data('autocomplete-source'), minLength: 3});
$('#asset_model_name').autocomplete({source: $('#asset_model_name').data('autocomplete-source'), minLength: 3});
$('#asset_color_name').autocomplete({source: $('#asset_color_name').data('autocomplete-source'), minLength: 3});
$('#asset_kind_name').autocomplete({source: $('#asset_kind_name').data('autocomplete-source'), minLength: 3})
$('#asset_body_name').autocomplete({source: $('#asset_body_name').data('autocomplete-source'), minLength: 3});

//Autocomplete for the contract form
$('#contract_lessee_name').autocomplete({
    source: $('#contract_lessee_name').data('autocomplete-source'),
    minLength: 4
});

// Toggle disable when imported/assembled is checked on the new asset form.
$("#asset_importd_assembld").change(function() {
    var $input = $(this);
    var $datefield = $('#asset_import_date');
    if ($input.prop('checked')){
      $datefield.prop('disabled', false);
    } else {
      $datefield.prop('disabled', true)
    }
}).change();

// Time picker included on the inspections form.
$('.datetime-field').datetimepicker({
      timeFormat: 'hh:mm tt z',
      controlType: 'select',
      timeText: 'Hora:',
      hourText: 'Hora',
      minuteText: 'Minuto',
      timezoneText: 'Zona',
      currentText: 'Ahora',
      closeText: 'Cerrar',
});
