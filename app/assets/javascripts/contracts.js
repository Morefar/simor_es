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
  $('#contract_expiration_date').val($startDate.getFullYear()+'/'+($startDate.getMonth()+1)+'/'+$startDate.getDate());
};

// Update expiration date based on first canon date and number of periods.
$('#contract_periodicity').change(function() { updateExpirationField() });
$('#contract_duration').change(function() { updateExpirationField() });

// Autocomplete behaviour after selection
$('#inspection_order_form_contract_number, #asset_contract_number').
  on("autocompleteclose",
    function( event, ui ){
        var selectedContractNumber = $(this).val();
        $.get("/es/contracts.json",
            { number: selectedContractNumber },
            function( data ) {
              $.get("/es/contracts/" + data + ".js")
              .fail(function(){ alert("Contrato no encontrado");
              });
            },
            "json"
        );
});

//Autocomplete behaviour in forms
$(function() {
    $('.autocomplete')
    .each(function() {
            $(this).autocomplete({
                source: $(this).data('autocomplete-source'),
                minLength: 2
            });
    });
});

// Toggle disable when imported/assembled is checked on the Asset form.
$("#asset_importd_assembld").change(function() {
    var $input = $(this);
    var $datefield = $('#asset_import_date');
    if ($input.prop('checked')){
      $datefield.prop('disabled', false);
    } else {
      $datefield.prop('disabled', true)
    }
}).change();

/**
 * Inspection related JS.
 **/

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

/* Inicialización en español para la extensión 'UI date picker' para jQuery. */
/* Traducido por Vester (xvester@gmail.com). */
jQuery(function($){
  $.datepicker.regional['es'] = {
      closeText: 'Cerrar',
      prevText: '&#x3c;Ant',
      nextText: 'Sig&#x3e;',
      currentText: 'Hoy',
      monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
        'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
      monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
        'Jul','Ago','Sep','Oct','Nov','Dic'],
      dayNames: ['Domingo','Lunes','Martes','Mi&eacute;rcoles','Jueves','Viernes','S&aacute;bado'],
      dayNamesShort: ['Dom','Lun','Mar','Mi&eacute;','Juv','Vie','S&aacute;b'],
      dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','S&aacute;'],
      weekHeader: 'Sm',
      dateFormat: 'yy/mm/dd',
      firstDay: 1,
      showMonthAfterYear: false,
      yearSuffix: '',
      isRTL: false
  };
  $.datepicker.setDefaults($.datepicker.regional['es']);
});

// Autocomplete behaviour for the inspection form.
$('#inspection_asset_license_plate').on("autocompleteclose",
    function( event, ui ){
        var selectedLicensePlate = $(this).val();
        $.get("/es/assets.json",
            { asset_license_plate: selectedLicensePlate },
            function( data ) {
              $.get("/es/assets/" + data + ".js");
            },
            "json"
        );
});
