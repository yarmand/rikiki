window.render_md = () ->
  converter = new Showdown.converter
  content = converter.makeHtml($('#content').val())
  $('#html_out').html(content)

$('#bt_edit').click () ->
  $('#markdown').toggle()
$('#bt_preview').click () ->
  render_md()
  pos = $('#html_out').offset()
  $('body').animate({ scrollTop: pos.top })
$('#bt_show_edit').click () ->
  $('body').animate({ scrollTop: 0 })



render_md()


