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
  $('#invoice-tabs').tabs();
  $('.invoice-tab').on('click', function() {
    var restaurantId = $(this).data('restaurant-id');
    $.ajax({
      method: 'GET',
      url: 'invoices',
      data: {restaurant_id: restaurantId},
      success: function(data) {
        $('#' + restaurantId).html(data);
      }
    })
  })
})
