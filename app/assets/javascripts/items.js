$(document).on('ready page:load', function() {

  $('#items_search_field').on('keyup', function() {
    var data = {"search": $('#items_search_field').val()};
    $.ajax({
      method: 'GET',
      url: '/items',
      data: data,
      success: function(data) {
        $('.items-list').html(data);
      }
    })
  })
})
