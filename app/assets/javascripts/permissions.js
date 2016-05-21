$(document).on('ready page:load', function() {
  $('.permission-accordion').accordion({
    active: false,
    collapsible: true
  });

  $('.permission-user').on('click', '.permission-edit-button', function(e) {
    e.preventDefault();
    $('.permission-modal').css('display', 'block');
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.permission-modal').addClass('edit-button'),
        $('.permission-modal').html(data);
      }
    })
  })
  $('.permission-modal').on('submit', 'form', function(e) {
    e.preventDefault();
    var formData = $(this).serialize();
    if ($('.permission-modal').hasClass('edit-button')) {
      $.ajax({
        method: 'PATCH',
        url: $(this).attr('action'),
        data: formData,
        dataType: 'html',
        success: function() {
          $('.permission-modal').css('display', 'none');
          $('.permission-modal').removeClass('edit-button');
        }
    })} else if ($('.permission-modal').hasClass('submit-button')) {
      $.ajax({
        method: 'POST',
        url: $(this).attr('action'),
        data: formData,
        dataType: 'html',
        success: function() {
          $('.permission-modal').removeClass('submit-button');
          $('.permission-modal').css('display', 'none');
        }
      })
    }
  })
  $('.permission-new-button').on('click', function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
      method: 'GET',
      url: $(this).attr('href') + '/new',
      data: {data: $(this).attr('data')},
      dataType: 'html',
      success: function(data) {
        $('.permission-modal').css('display', 'block'),
        $('.permission-modal').addClass('submit-button'),
        $('.permission-modal').html(data)
      }
    })
  })
})
