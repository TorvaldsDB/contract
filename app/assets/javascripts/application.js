// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery_nested_form
//= require bootstrap-datetimepicker
var init_datepicker = function(options) {
  var get_option = function(jq) {
    if ($.type(jq) == 'string') {
      jq = $(jq)
    }

    var data_options = jq.data("datepicker") || {};
    if (options) {
      return $.extend(data_options, options)
    } else {
      return data_options
    }
  }

  var picker = $('.js_datepicker');

  if (picker.length > 0) {
    picker.datetimepicker(get_option(picker))
  }
}

$(document).ready(function() {
  $(".js_datepicker").datetimepicker();
});
