(function() {

  window.render_md = function() {
    var content;
    content = Markdown($('#content').val());
    $('#html_out').html(content);
    return put_toc($('#html_out'));
  };

  window.put_toc = function(root) {
    var i, titles, toc;
    toc = $('<div id="toc">');
    titles = $('<ul>');
    toc.append(titles);
    i = 1;
    root.children('h1').each(function(i, e) {
      var anchor, li, title;
      anchor = $("<a name='" + i++ + "'>");
      $(e).prepend(anchor);
      title = $(e).text();
      console.log(title);
      li = $("<li><a href='#" + i + "'>" + title + '</a></li>');
      return titles.append(li);
    });
    return root.prepend(toc);
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

  $('#save_continue').click(function() {
    var data, url;
    url = document.location.origin + document.location.pathname;
    data = {
      content: $('#markdown #content').val()
    };
    $('#notice').html(' ... ');
    return $.post(url, data, function() {
      return $('#notice').html('Saved !').fadeOut(500).html('').fadeIn();
    });
  });

  render_md();

}).call(this);
