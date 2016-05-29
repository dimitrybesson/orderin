$(document).on('ready page:load', function() {
  $('.permission-accordion').accordion({
    active: false,
    collapsible: true
  });

  $('.permission-user').on('click', '.permission-edit-button', function(e) {
    e.preventDefault();
    $('.permissions-modal').toggleClass('hidden');
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.permissions-modal').addClass('edit-button'),
        $('.permissions-modal').html(data);
      }
    })
  })
  $('.permissions-modal').on('submit', 'form', function(e) {
    e.preventDefault();
    var formData = $(this).serialize();
    if ($('.permissions-modal').hasClass('edit-button')) {
      $.ajax({
        method: 'PATCH',
        url: $(this).attr('action'),
        data: formData,
        dataType: 'html',
        success: function() {
          $('.permissions-modal').toggleClass('hidden');
          $('.permissions-modal').removeClass('edit-button');
        }
    })} else if ($('.permissions-modal').hasClass('submit-button')) {
      $.ajax({
        method: 'POST',
        url: $(this).attr('action'),
        data: formData,
        dataType: 'html',
        success: function() {
          $('.permissions-modal').removeClass('submit-button');
          $('.permissions-modal').toggleClass('hidden');
        }
      })
    }
  })
  $('.permission-new-btn').on('click', function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
      method: 'GET',
      url: $(this).attr('href') + '/new',
      data: {data: $(this).attr('data')},
      dataType: 'html',
      success: function(data) {
        $('.permissions-modal').toggleClass('hidden');
        $('.permissions-modal').addClass('submit-button');
        $('.permissions-modal').html(data);
      }
    })
  })
  $('.permission-user').draggable({
    revert: true
  });
  $('.permission-remove-icon').droppable({
    tolerance: 'pointer',
    accept: '.permission-user',
    over: function(event, ui) {
      $(this).addClass('permission-remove-icon-dragover');
    },
    out: function(event, ui) {
      $(this).removeClass('permission-remove-icon-dragover');
    },
    drop: function(event, ui) {
      var permissionId = ui.draggable.data('permission-id');
      $(this).removeClass('permission-remove-icon-dragover');
      $.ajax({
        method: 'DELETE',
        url: '/permissions/' + permissionId,
        dataType: 'html',
        success: function() {
          ui.draggable.remove();
        }
      })
    }
  })
  $('.permissions-modal').on('click', '.permissions-modal-close-btn', function() {
    $('.permissions-modal').toggleClass('hidden');
  })
})
