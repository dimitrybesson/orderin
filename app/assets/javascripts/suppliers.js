$(document).on('ready page:load', function() {
  $('.supplier-order-modal').on('click', function(e) {
    e.stopPropagation();
  });
  $('.supplier-show-body').on('click', function() {
    $('.supplier-order-modal').css('display', 'none');
  });
  $('.supplier-show-body').on('click', '.supplier-order-button', function(e) {
    e.stopPropagation();
    $('.supplier-order-modal').css('display', 'block');
  })
})
