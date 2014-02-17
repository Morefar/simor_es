// Date Picker behavior.
(function() {
  $(function() {
    $.datepicker.setDefaults({
      regional: "es",
      changeMonth: true,
      changeYear: true,
      yearRange: "2000:2020",
      closeText: "Cerrar",
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

// Contract form remove cosigners behaviour
$("form").on("click", ".remove_cosigners", function(event) {
  $(this).prev('input[type=hidden]').val(1);
  $(this).closest('.row').hide();
  event.preventDefault();
});

// Contract form add cosigners field behaviour
$("form").on("click", ".add_fields", function(event) {
  var time = new Date().getTime();
  regexp = new RegExp($(this).data('id'), 'g');
  $(this).before($(this).data('fields').replace(regexp, time))
  $autoField = $(this).prev('.row').find('.autocomplete').first();
  $autoField.autocomplete({ source: $autoField.data("autocomplete-source"), minLength: 2 });
  event.preventDefault();
});

// Contract index search form
$( "input[name^=query_options]" ).on("click", function() {
  var input = $(this)[0];
  var $searchField = $( "#contract_query" );
  var byDate = $( "#query_options_by_date" )[0];
  var byDateRange = $( "#query_options_by_range" )[0];
  var byLessee = $( "#query_options_by_lessee" )[0];
  var byNumber = $("#query_options_by_number")[0];
  $searchField.autocomplete();
  if(input == byDate) {
      $searchField.attr('placeholder', 'dd/mm/yyyy');
      $searchField.addClass( "dateField" )
      $(".dateField").datepicker({ dateFormat: "dd/mm/yy" });
  } else {
      $(".dateField").datepicker( "destroy" );
      $searchField.removeClass( "dateField" );
      $searchField.attr('placeholder', 'Buscar');
      if(input == byLessee) {
        $searchField.autocomplete({
          source: "/es/entities.json",
          minLength: 2
        });
      } else {
        if(input == byNumber) {
          $searchField.autocomplete({
            source: "/es/contracts.json",
            minLength: 4
          });
        } else {
          $searchField.removeClass();
          $searchField.autocomplete( "destroy" );
          $searchField.attr('placeholder', 'dd/mm/yyyy - dd/mm/yyyy');
        }
      }
  }
  return $searchField.focus();
});

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
$('#asset_contract_number').
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

$("#inspection_inspection_order_id," +
  " #inspection_asset_license_plate, #asset_contract_number").each(function() {
  if($(this).val() != "") {
    $(this).prop('readonly', true);
  };
});

//
// Inspection Orders Behaviour
$("#inspection_order_status").on('change', function (event) {
  if ($(this).val() === "schedule") {
    $("#inspection_order_scheduled_date").prop('disabled', false);
    $("#inspection_order_scheduled_date").focus();
  } else {
    $("#inspection_order_scheduled_date").prop('disabled', true);
    }
});


$('input:radio[name=options]').on("click", function() {
  var input = $(this)[0];
  var $searchField = $("#query");
  var option = $('input:radio[name=options]:checked').val();
  if(option === "by_date") {
    $searchField.attr('placeholder', 'dd/mm/yyyy');
    $searchField.addClass( "dateField" )
    $(".dateField").datepicker({ dateFormat: "dd/mm/yy" });
  } else {
    if ($searchField.hasClass("dateField")) {
      $searchField.datepicker("destroy");
      $searchField.removeClass("dateField");
    }
    if(option === "by_range") {
      $searchField.attr('placeholder', "dd/mm/yyyy - dd/mm/yyyy");
    } else {
      $searchField.attr('placeholder', "Buscar");
    }
  }
  return $searchField.focus();
});

$('input:radio[name$="[number_from]"]').on("click", function() {
  var input = $(this)[0];
  var $searchField = $( "#inspection_order_form_number" );
  var option = $('input:radio[name$="[number_from]"]:checked').val();
  $searchField.autocomplete();
  if(option === "contract") {
    $searchField.autocomplete({
      source: "/es/contracts.json",
      minLength: 2
    });
  } else {
    $searchField.autocomplete({
      source: "/es/assets.json",
      minLength: 2
    });
  }
  return $searchField.focus();
});

$('#inspection_order_form_number').
  on("autocompleteclose",
    function( event, ui ){
        var selectedNumber = $(this).val();
        var option = $('input:radio[name$="[number_from]"]:checked').val();
        if (option === "contract") {
          $.get("/es/contracts.json",
              { number: selectedNumber },
              function( data ) {
                $.get("/es/contracts/" + data + ".js")
                .fail(function(){ alert("Contrato no encontrado");
                });
              },
              "json"
          );
        } else {
          $.get("/es/assets.json",
              { asset_license_plate: selectedNumber },
              function( data ) {
                $.get("/es/assets/" + data + ".js")
                .fail(function(){ alert("Activo no encontrado");
                });
              },
              "json"
          );
        }
});
