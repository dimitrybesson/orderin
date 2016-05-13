$(document).on('ready page:load', function() {

  $('.new_order_item').on('submit', function(event) {
    event.preventDefault();

    var inventoryItem = $(this).parent().parent()


    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.order-details').html(data);
        // $('#order_item_quantity', this).val('');
        inventoryItem.remove();
      }
    });
  });


  $('.order-items').on('click', '.order-item-delete', function(event) {
    event.preventDefault();
    event.stopImmediatePropagation();

    console.log(this)

    var orderItem = $(this).parent().parent()


    $.ajax({
      method: 'DELETE',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.inventory-items').prepend(data);
        orderItem.remove();
      }
    });



  })





});
