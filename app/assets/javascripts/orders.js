$(document).on('ready page:load', function() {

  $('.new_order_item').on('submit', function(event) {
    event.preventDefault();



    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.order-details').html(data);
        $('#order_item_quantity', this).val('');
      }.bind(this)
    });
  });





});
