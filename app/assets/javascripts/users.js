$(document).on('ready page:load', function() {

  $('body').on('click', '.restaurant, .supplier', function() {

    $(this).toggleClass('selected');

    var selectedRestaurantIdArray = [];
    var selectedSupplierIdArray = [];

    $('.restaurant.selected').each(function() {
      selectedRestaurantIdArray.push($(this).attr('data-id'))
    });

    $('.supplier.selected').each(function() {
      selectedSupplierIdArray.push($(this).attr('data-id'))
    });

    // this is for when all restaurants are unselected, need to clear the suppliers section
    if (selectedRestaurantIdArray.length === 0) {
      console.log('nothing is selected')
      $('.user-suppliers').html('')
      $('.orders-collection').html('')
    }
    else if (selectedSupplierIdArray.length === 0) {
      // Get all suppliers for all restaurants

      // var data = {restaurant_ids: selectedRestaurantIdArray}

      $.ajax({
        method: 'GET',
        url: '/suppliers',
        data: {restaurant_ids: selectedRestaurantIdArray},
        dataType: 'html',
        success: function(data) {
          $('.user-suppliers').html(data);
        }
      })

      // Get all orders for selected restaurants
      $.ajax({
        method: 'GET',
        url: '/orders',
        data: {restaurant_ids: selectedRestaurantIdArray},
        dataType: 'html',
        success: function(data) {
          $('.orders-collection').html(data);
        }
      })
    }
    // this is for when there are restaurants and suppliers
    // can be refactored to only check presence of suppliers, because there cannot be any suppliers on the page without a restaurant being selected first
    else if (selectedRestaurantIdArray.length > 0 && selectedSupplierIdArray.length > 0) {

      $.ajax({
        method: 'GET',
        url: '/orders',
        data: {restaurant_ids: selectedRestaurantIdArray, supplier_ids: selectedSupplierIdArray},
        dataType: 'html',
        success: function(data) {
          console.log('IT WORKS')
          $('.orders-collection').html(data);
        }
      })
    }

  });

});
