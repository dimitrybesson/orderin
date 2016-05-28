$(document).on('ready page:load', function() {
  $('.restaurant-creation').on('click', function(e) {
    e.preventDefault();
    $('.signup-modal').addClass('modal-on');
    $.ajax({
      method: 'GET',
      url: $(this).children('a').attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.signup-modal').html(data);
      }
    })
  })
})
