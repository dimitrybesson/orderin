$(document).on('ready page:load', function() {

  function orderTotalUpdate() {

    $.ajax({
      method: 'GET',
      dataType: 'html',
      success: function(data) {
        $('.order-calculations').html(data);
      }
    });
  }

// Add and create order_item by selecting inventory_item
  $('.inventory-items').on('submit', '.new_order_item', function(event) {
    event.preventDefault();

    var inventoryItem = $(this).parent().parent()

    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.order-items').append(data);
        // $('#order_item_quantity', this).val('');
        inventoryItem.remove();
        orderTotalUpdate();
      }
    });
  });

// Destroy and remove order_item from order_summary
  $('.order-details').on('click', '.order-item-delete', function(event) {
    event.preventDefault();
    event.stopImmediatePropagation();

    var orderItem = $(this).parent().parent()

    $.ajax({
      method: 'DELETE',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.inventory-items').prepend(data);
        orderItem.remove(); //instead, we are going to remove order-item
        orderTotalUpdate();
      }
    });
  });





// Hover over order_item to see edit option and pointer cursor
  $('.order-details').on('mouseover', '.order-item', function() {

    var orderItemRight = $(this).children();
    var editIconContainer = orderItemRight.children('.edit-icon-container');
    var editIcon = editIconContainer.children(); //Assumes there is ever only one child in editIconContainer

    editIcon.toggleClass('hidden');
    $(this).css({cursor: 'pointer'});
  });

  $('.order-details').on('mouseout', '.order-item', function() {

    var orderItemRight = $(this).children();
    var editIconContainer = orderItemRight.children('.edit-icon-container');
    var editIcon = editIconContainer.children();

    editIcon.toggleClass('hidden');
  });

// Click order_item to show edit order_item form
  $('.order-details').on('click', '.order-item', function() {
    var orderItemRight = $(this).children();
    var editIconContainer = orderItemRight.children('.edit-icon-container');
    var orderItemQuantity = orderItemRight.children('.order-item-quantity');

    orderItemQuantity.toggleClass('hidden');
    editIconContainer.remove();

    var editOrderForm = orderItemRight.children('.edit_order_item');
    editOrderForm.toggleClass('hidden');
  });


});
