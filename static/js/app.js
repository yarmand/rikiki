(function() {

  window.render_md = function() {
    var content, converter;
    converter = new Showdown.converter;
    content = converter.makeHtml($('#content').val());
    return $('#html_out').html(content);
  };

  $('#bt_edit').click(function() {
    return $('#markdown').toggle();
  });

  $('#bt_preview').click(function() {
    var pos;
    render_md();
    pos = $('#html_out').offset();
    return $('body').animate({
      scrollTop: pos.top
    });
  });

  $('#bt_show_edit').click(function() {
    return $('body').animate({
      scrollTop: 0
    });
  });

  render_md();

}).call(this);
