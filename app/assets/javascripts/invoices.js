$(document).on('ready page:load', function() {
  $('.invoice-ship-btn').on('submit', function(e) {
    e.preventDefault();

    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      dataType: 'html',
      success: function() {
        $('.invoice-ship-btn').remove();
        $('.order-shipped-img').fadeIn();
        $('.order-shipped-img').removeClass('hidden');
        $('.order-shipped-img').addClass('order-shipped-img-active');
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
        if (data.trim() == "") {
          $('#' + restaurantId).html("<p>Nothing here yet!</p>");
        } else {
          $('#' + restaurantId).html(data);
        }
      }
    })
  })
  $('.deliveries-modal').on('submit', '.invoice-receive-btn', function(e) {
    e.preventDefault();

    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      dataType: 'html',
      success: function() {
        $(this).parent().find('.order-received-img').addClass('order-received-img-active');
        $(this).remove();
      }.bind(this)
    })
  })
  $('.invoice-show-receive-btn').on('submit', function(e) {
    e.preventDefault();

    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      dataType: 'html',
      success: function() {
        $(this).remove();
        $('.invoice-show-receive-img').addClass('invoice-show-receive-img-active');
      }.bind(this)
    })
  })
  $('#invoices_search').on('keyup', function() {
    var data = {"search": $('#invoices_search').val()};
    $.ajax({
      method: "GET",
      url: "/invoices",
      data: data,
      dataType: 'html',
      success: function(data) {
        $('.supplier-invoices-list').html(data);
      }
    })
  })
})
