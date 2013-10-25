$(function() {
  $('.alert-success').hide();
  $('#status-update').click(function() {
    $('.alert-success').empty().append('Bicycle status updated').show();
    setTimeout(function(){$('.alert-success').fadeOut()},3000);
  });
});
