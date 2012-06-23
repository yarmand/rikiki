window.render_md = () ->
  # converter = new Showdown.converter
  # content = converter.makeHtml($('#content').val())
  content = Markdown($('#content').val())
  $('#html_out').html(content)
  put_toc($('#html_out'))

window.put_toc = (root) ->
  toc = $('<div id="toc">')
  titles = $('<ul>')
  toc.append(titles)
  i =1
  root.children('h1').each (i,e) ->
    anchor = $("<a name='"+ i++ +"'>")
    $(e).prepend(anchor)
    title = $(e).text()
    console.log title
    li = $("<li><a href='#"+i+"'>"+title+'</a></li>')
    titles.append(li)
  root.prepend(toc)

$('#bt_edit').click () ->
  $('#markdown').toggle()
$('#bt_preview').click () ->
  $('#html_out').show()
  render_md()
  pos = $('#html_out').offset()
  $('body').animate({ scrollTop: pos.top })
$('#bt_show_edit').click () ->
  $('body').animate({ scrollTop: 0 })
  $('#html_out').hide()

$('#save_continue').click () ->
  url = document.location.origin + document.location.pathname
  data =
      content: $('#markdown #content').val()
  $('#notice').html(' ... ')
  $.post url, data, () ->
      $('#notice').html('Saved !').fadeOut(500).html('').fadeIn()

render_md()


