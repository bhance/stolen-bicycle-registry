$(function() {
  $('#user_country').change(function() {         
    if ($(this).val() == 'Canada') {
      $('#states').hide(); 
      $('#canada').show(); 
    } else { 
      $('#canada').hide();
      $('#states').show(); 
    }
  });
});

$(function() {
  $('#bicycle_country').change(function() {         
    if ($(this).val() == 'Canada') {
      $('#states').hide(); 
      $('#canada').show(); 
    } else { 
      $('#canada').hide();
      $('#states').show(); 
    }
  });
});

