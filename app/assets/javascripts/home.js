$(document).on('ready page:load', function() {
  $('.deliveries-link').on('click', function(e) {
    e.preventDefault();
    $('.deliveries-modal').toggleClass('hidden');
    $.ajax({
      method: 'GET',
      url: '/orders/deliveries',
      dataType: 'html',
      success: function(data) {
        $('.deliveries-modal').html(data);
      }
    })
  })

  $('.deliveries-modal').on('click', '.deliveries-modal-close-btn', function() {
    $('.deliveries-modal').toggleClass('hidden');
  })
})
