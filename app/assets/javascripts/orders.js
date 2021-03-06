$(document).on('ready page:load', function() {

  function orderTotalUpdate(order) {

    $.ajax({
      url: '/orders/' + order +'/edit',
      method: 'GET',
      dataType: 'html',
      success: function(data) {
        $('.order-calculations').html(data);
      }
    });
  }

  $(function() {
    $( document ).tooltip();
  });

// Search bar to filter order_items

  $('#inventory_search').on('keyup', function() {
    var data = {"search": $('#inventory_search').val()};
    var orderId = $('#inventory_search').attr('data');
    $.ajax({
      method: 'GET',
      url: '/orders/' + orderId,
      data: data,
      success: function(data) {
        $('.inventory-item').remove();
        $('.inventory-item-table-heading-row').after(data);
        $('.inventory-item-draggable').draggable({ revert: 'invalid' });
      }
    })
  })

// Add and create order_item by selecting inventory_item
  $('.inventory-items').on('submit', '.new_order_item', function(event) {
    event.preventDefault();
    var inventoryItem = $(this).parent().parent()
    orderId = $(this).attr('data');
    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.order-items').append(data);
        $('.order-item-draggable').draggable({ revert: 'invalid'});
        inventoryItem.remove();
        orderTotalUpdate(orderId);
      }
    });
  });

// Destroy and remove order_item from order_summary
  $('.order-items').on('click', '.order-item-delete', function(event) {
    event.preventDefault();
    event.stopImmediatePropagation();

    var orderItem = $(this).parent().parent();
    orderId = $(this).attr('data');
    $.ajax({
      method: 'DELETE',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.inventory-item-table-heading-row').after(data);
        $('.inventory-item-draggable').draggable({ revert: 'invalid' });
        orderItem.remove(); //instead, we are going to remove order-item
        orderTotalUpdate(orderId);
      }
    });
  });

// Update order_item
  $('.order-items').on('submit', '.edit_order_item', function(event) {
    event.preventDefault();

    var orderItem = $(this).parent().parent();
    orderId = $(this).attr('data');
    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      data: $(this).serialize(),
      dataType: 'html',
      success: function(data) {
        orderItem.replaceWith(data);
        orderTotalUpdate(orderId);
        $('.order-item-draggable').draggable({ revert: 'invalid'});
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

    var orderItemEditCell = $(this).children('.cell-order-item-edit');
    var editIcon = orderItemEditCell.children('.edit-icon');

    editIcon.toggleClass('hidden');
    $(this).css({cursor: 'pointer'});

  });

  $('.order-items').on('mouseout', '.order-item', function() {

    var orderItemEditCell = $(this).children('.cell-order-item-edit');
    var editIcon = orderItemEditCell.children('.edit-icon');
    editIcon.toggleClass('hidden');

  });

  $('.order-items').on('click', '.edit_order_item', function(event) {
    event.stopPropagation();
  });

// Click order_item to show edit order_item form
  $('.order-items').on('click', '.order-item', function() {

    var quantityCell = $(this).children('.cell-order-item-quantity');
    var quantityValue = quantityCell.children('.order-item-quantity-value');
    quantityValue.toggleClass('hidden');

    var quantityForm = quantityCell.children('.edit_order_item');
    quantityForm.toggleClass('hidden');

    if (quantityCell.attr('colspan')) {
      quantityCell.removeAttr('colspan');
    } else {
      quantityCell.attr('colspan', '2');
    }

    var editCell = $(this).children('.cell-order-item-edit');
    editCell.toggleClass('hidden');

  });

  // $(function() {
    $('.inventory-item-draggable').draggable({ revert: 'invalid' });
    $('.inventory-item-droppable').droppable({
      tolerance: 'pointer',
      accept: '.inventory-item-draggable',
      over: function(event, ui) {
        $(this).addClass('order-dragover');
      },
      out: function(event, ui) {
        $(this).removeClass('order-dragover');
      },
      drop: function(event, ui) {
        var formData = (ui.draggable.find('form'));
        var orderId = formData.attr('data');
        $(this).removeClass('order-dragover');
        $.ajax({
          method: 'POST',
          url: '/order_items',
          dataType: 'html',
          data: formData.serialize(),
          success: function(data) {
            $('.order-items').append(data);
            $('.order-item-draggable').draggable({ revert: 'invalid'});
            ui.draggable.remove();
            orderTotalUpdate(orderId);
          }
        });
      }
    });
    $('.order-item-draggable').draggable({ revert: 'invalid' });
    $('.order-item-droppable').droppable({
      tolerance: 'pointer',
      accept: '.order-item-draggable',
      over: function(event, ui) {
        $(this).addClass('inventory-dragover');
      },
      out: function(event, ui) {
        $(this).removeClass('inventory-dragover');
      },
      drop: function(event, ui) {
        var deleteUrl = ui.draggable.find('form').attr('action');
        var orderId = ui.draggable.find('form').attr('data');
        $(this).removeClass('inventory-dragover');
        $.ajax({
          method: 'DELETE',
          url: deleteUrl,
          dataType: 'html',
          success: function(data) {
            $('.inventory-item-table-heading-row').after(data);
            $('.inventory-item-draggable').draggable({ revert: 'invalid' });
            ui.draggable.remove();
            orderTotalUpdate(orderId);
          }
        })
      }
    })
  //ORDER INDEX FILTERING
  //
  $('.filter-option').on('click', function() {
    $(this).toggleClass('filter-option-active');

    var filterRestaurantIdList = [];
    var filterOrderStatusList = [];
    $('.filter-restaurant.filter-option-active').each(function() {
      filterRestaurantIdList.push($(this).data('restaurant-id'));
    })
    $('.filter-status.filter-option-active').each(function() {
      filterOrderStatusList.push($(this).data('status'));
    })

    $.ajax({
      method: 'GET',
      url: '/filter_index',
      data: {filter_restaurant_ids: filterRestaurantIdList, filter_statuses: filterOrderStatusList},
      dataType: 'html',
      success: function(data) {
        $('.selected-orders').html(data);
      }
    })
  })


});
