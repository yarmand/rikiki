(function() {

  window.render_md = function() {
    var content, converter;
    converter = new Showdown.converter;
    content = Markdown($('#content').val());
    return $('#html_out').html(content);
  };

  $('#bt_edit').click(function() {
    return $('#markdown').toggle();
  });

  $('#bt_preview').click(function() {
    var pos;
    $('#html_out').show();
    render_md();
    pos = $('#html_out').offset();
    return $('body').animate({
      scrollTop: pos.top
    });
  });

  $('#bt_show_edit').click(function() {
    $('body').animate({
      scrollTop: 0
    });
    return $('#html_out').hide();
  });

  render_md();

}).call(this);
