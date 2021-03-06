$(document).on('ready page:load', function() {
  $('.permission-accordion').accordion({
    active: false,
    collapsible: true
  });

  $('.permission-new-btn').on('click', function(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    $.ajax({
      method: 'GET',
      url: $(this).attr('href') + '/new',
      data: {data: $(this).attr('data')},
      dataType: 'html',
      success: function(data) {
        $(this).parent().siblings('.permission-users').addClass('target-restaurant');
        $('.permissions-modal').toggleClass('hidden');
        $('.permissions-modal').addClass('create-button');
        $('.permissions-modal').html(data);
      }.bind(this)
    })
  })

  $('.permission-users').on('click', '.permission-edit-button', function(e) {
    e.preventDefault();
    $('.permissions-modal').toggleClass('hidden');
    $.ajax({
      method: 'GET',
      url: $(this).attr('href'),
      dataType: 'html',
      success: function(data) {
        $('.permissions-modal').addClass('edit-button'),
        $('.permissions-modal').html(data);
        $('.permissions-modal').attr('data', $(this).parents('li').data('permission-id'));
      }.bind(this)
    })
  })

  $('.permissions-modal').on('submit', 'form', function(e) {
    e.preventDefault();
    var formData = $(this).serialize();
    var permissionId = $('.permissions-modal').attr('data');
    var permissionElement = 'li[data-permission-id=' + permissionId + ']'
    if ($('.permissions-modal').hasClass('edit-button')) {
      $.ajax({
        method: 'PATCH',
        url: $(this).attr('action'),
        data: formData,
        dataType: 'html',
        success: function(data) {
          $('.permissions-modal').toggleClass('hidden');
          $('.permissions-modal').removeClass('edit-button');
          $(permissionElement).replaceWith(data);
          $(permissionElement).draggable({
            revert: true
          });
          $('.permissions-modal').removeAttr('data');
        }
    })} else if ($('.permissions-modal').hasClass('create-button')) {
      $.ajax({
        method: 'POST',
        url: $(this).attr('action'),
        data: formData,
        dataType: 'html',
        success: function(data) {
          $('.permissions-modal').removeClass('create-button');
          $('.permissions-modal').toggleClass('hidden');
          $('.target-restaurant').append(data);
          $('.target-restaurant').removeClass('target-restaurant');
          $('.permission-user').draggable({
            revert: true
          })
        }
      })
    }
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
    $('.target-restaurant').removeClass('target-restaurant');
  })
})
