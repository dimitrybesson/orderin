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
  $('.order-items').on('click', '.order-item-delete', function(event) {
    event.preventDefault();
    event.stopImmediatePropagation();

    var orderItem = $(this).parent().parent();

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

// Update order_item
  $('.order-items').on('submit', '.edit_order_item', function(event) {
    event.preventDefault();

    var orderItem = $(this).parent().parent();

    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      data: $(this).serialize(),
      dataType: 'html',
      success: function(data) {
        orderItem.replaceWith(data);
        orderTotalUpdate();
      }

    });
  });

// Submit all open edit boxes to update on clicking Update Order submit
  $('.edit_order').on('submit', function(event) {
    var activeForms = $('.edit_order_item').not('.hidden');
    var forms = [];
    activeForms.each(function(index, form) {
      var formAction = $(this).attr('action');
      var newQuantity = $(this).children('#order_item_quantity').val();
      // var serializedForm = $(this).serialize();
      forms.push([formAction, newQuantity]);
    });

    var formData = {};
    formData['formInfo'] = forms;

    if (activeForms.length > 0) {
      $.ajax({
        method: 'PATCH',
        url: '/order_items',
        data: formData
      });
    }
  });



// Hover over order_item to see edit option and pointer cursor
  $('.order-items').on('mouseover', '.order-item', function() {

    var orderItemRight = $(this).children();
    var editIconContainer = orderItemRight.children('.edit-icon-container');
    var editIcon = editIconContainer.children(); //Assumes there is ever only one child in editIconContainer

    editIcon.toggleClass('hidden');
    $(this).css({cursor: 'pointer'});
  });

  $('.order-items').on('mouseout', '.order-item', function() {

    var orderItemRight = $(this).children();
    var editIconContainer = orderItemRight.children('.edit-icon-container');
    var editIcon = editIconContainer.children();

    editIcon.toggleClass('hidden');
  });

  $('.order-items').on('click', '.edit_order_item', function(event) {
    event.stopPropagation();
  });

// Click order_item to show edit order_item form
  $('.order-items').on('click', ('.order-item'), function() {
    var orderItemRight = $(this).children();
    var editIconContainer = orderItemRight.children('.edit-icon-container');
    var orderItemQuantity = orderItemRight.children('.order-item-quantity');

    orderItemQuantity.toggleClass('hidden');
    editIconContainer.remove();

    var editOrderForm = orderItemRight.children('.edit_order_item');
    editOrderForm.toggleClass('hidden');
  });



});
