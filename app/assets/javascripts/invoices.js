$(document).on('ready page:load', function() {
  $('.invoice-ship-btn').on('submit', function(e) {
    e.preventDefault();

    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      dataType: 'html',
      success: function() {
        $('.invoice-ship-btn').remove();
      }
    })
  })
})
