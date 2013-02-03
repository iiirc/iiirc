$(document).ready(function() {
  $('input[readonly="readonly"]').focus(function() {
    $(this).select();
  });
});