// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  // $('.restaurant').on('click', function() {
  //
  //   var restaurantId = $(this).attr('data-id')
  //   // console.log(restaurantId)
  //   $.ajax({
  //     method: 'GET',
  //     url: '/suppliers/',
  //     dataType: 'html',
  //     data: {restaurant_id: restaurantId},
  //     success: function(data) {
  //       $('.user-suppliers').html(data);
  //     }
  //   })
  // })

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

    if (selectedSupplierIdArray.length === 0) {
      // Get all suppliers for all restaurants

      $.ajax({
        method: 'GET',
        data: {restaurant_ids: selectedRestaurantIdArray},
        dataType: 'html'
      })


    }


  });

});
