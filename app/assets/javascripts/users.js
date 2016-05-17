// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  $('.user-restaurant').on('click', function() {

    var restaurantId = $(this).attr('data-id')
    // console.log(restaurantId)
    $.ajax({
      method: 'GET',
      url: '/users/' + restaurantId,
      dataType: 'html',
      data: {restaurant_id: restaurantId},
      success: function(data) {
        $('.user-suppliers').html(data);
      }
    })
  })

});
