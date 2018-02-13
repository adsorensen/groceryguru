// ENABLE NOTIFICATIONS
$('#notification_toggle').on('change', function() {
  var listHeight = $('.judgments-settings .list').outerHeight();
  var headerHeight = $('.judgments-settings .settings-legend').outerHeight();

  if ($(this).is(':checked')) {
    $('.judgments-settings').removeClass('disabled').stop().animate({ height: listHeight + headerHeight + 1 }, 500);
  } else {
    $('.judgments-settings').addClass('disabled').stop().animate({ height: 0 }, 500);;
  }
});

function updateFullName()
{
   document.getElementById('fullname').style.display = "none"
}

function updateUsername(username)
{
  if (document.getElementById('username_button').textContent == 'Click here to update')
  {
   document.getElementById('username').style.display = "none"
   document.getElementById('username_textbox').style.display = "inline-block"
   document.getElementById('username_button').textContent = 'Cancel'
  }
  else if (document.getElementById('username_button').textContent == 'Cancel')
  {
   document.getElementById('username').style.display = "inline-block"
   document.getElementById('username_textbox').style.display = "none"
   document.getElementById('username_button').textContent = "Click here to update"
  }
}