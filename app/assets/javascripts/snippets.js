$(document).ready(function() {
  var $readonly = $('input[readonly="readonly"]');
  $readonly.focus(function() {
    $(this).select();
  });
  $readonly.click(function() {
    $(this).select();
  });
});