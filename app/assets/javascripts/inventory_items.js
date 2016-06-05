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
  $('.new_inventory_item_btn').on('click', function(e) {
    e.preventDefault();
    $('.inventory-item-suggestion-modal').toggleClass('hidden');
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.inventory-item-suggestion-modal').html(data);
      }
    })
  })
  $('.inventory-item-suggestion-modal').on('click', '.create-new-item-btn', function(e) {
    e.preventDefault();
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.inventory-item-form-container').html(data);
      }
    })
  })
  $('.inventory-item-suggestion-modal').on('click', '.item-link', function(e) {
    e.preventDefault();
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.inventory-item-form-container').html(data);
        $(this).parent().addClass('activeForm');
      }.bind(this)
    })
  })
  $('.inventory-item-suggestion-modal').on('submit', ('.new_inventory_item'), function(e) {
    e.preventDefault();
    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.inventory-item-form-container').text("New inventory item created!");
        $('.activeForm').remove();
        $('.inventory-item-column-headings').after(data);
      }
    })
  })
  $('.inventory-item-suggestion-modal').on('submit', ('.new_item_and_inventory_item'), function(e) {
    e.preventDefault();
    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      dataType: 'html',
      data: $(this).serialize(),
      success: function(data) {
        $('.inventory-item-form-container').text("New inventory item created!");
        $('.inventory-item-column-headings').after(data);
      }
    })
  })
  $('.inventory-item-suggestion-modal').on('click', '.new-inventory-item-modal-close-btn', function() {
    $('.inventory-item-suggestion-modal').empty();
    $('.inventory-item-suggestion-modal').toggleClass('hidden');
  })
})
