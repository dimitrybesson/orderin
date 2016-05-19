$(document).on('ready page:load', function() {
  $('.supplier-order-modal').on('click', function(e) {
    e.stopPropagation();
  });
  $('.supplier-show-body').on('click', function() {
    $('.supplier-order-modal').css('display', 'none');
  });
  $('.supplier-order-button').on('click', function() {
    var supplierIdNumber = $('.supplier-order-button').attr('data');
    var supplierId = {supplierId: supplierIdNumber};
    $.ajax({
      method: 'GET',
      url: '/orders/new',
      dataType: 'html',
      data: supplierId,
      success: function(data) {
        $('.supplier-order-modal').html(data);
        $('.supplier-order-modal').css('display', 'block');
      }
    })
  })
})
