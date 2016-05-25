$(document).on('ready page:load', function() {

  $('.inventory').on('click', '.edit-inventory-item-btn', function(e) {
    e.preventDefault();
    e.stopPropagation();
    $(this).parents('tr').addClass('selected');
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.edit-inventory-item-modal').html(data);
        $('.edit-inventory-item-modal').toggleClass('hidden');
      }
    })
  })
  $('.edit-inventory-item-modal').on('submit', '.edit_inventory_item', function(e) {
    e.preventDefault();
    $.ajax({
      method: 'PATCH',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.selected').replaceWith(data);
        $('.edit-inventory-item-modal').toggleClass('hidden');
      }
    })
  })
  $('.edit-inventory-item-modal').on('click', '.modal-close-btn', function() {
    $('.edit-inventory-item-modal').toggleClass('hidden');
    $('.selected').removeClass('selected');
  })
})
