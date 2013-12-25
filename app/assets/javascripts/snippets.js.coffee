$ ->
  $('input[readonly="readonly"]').focus (event) ->
    $(event.target).select()
  .click (event) ->
    $(event.target).select()

  $('a[data-method="post"]').on "ajax:success", (data, status, xhr) ->
    $container = $(@).closest("p")
    $container.find(".count").text status.message.star_count
    if $container.find("img[data-user-id='#{status.user_id}']").length == 0
      $container.find(".starred-by").append("<img src='#{status.user.gravatar_url}' alt='#{status.user.username}' data-user-id='#{status.user_id}' class='starred-by-icon'>")
  .on "ajax:error", (xhr, status, error) ->
    status = $.parseJSON(status.responseText)
    msg = status.errors || "Error!"
    alert msg
  $contentTextarea = $('body#page_snippets_new #content-textarea')
  $contentTextarea.change (event) ->
    $('#preview .loading').show()
    content = $(event.target).val()
    if content == ''
      $('#preview .loading').hide()
      return
    $.ajax(url: '/snippets/preview', type: 'POST', data: $('#new_snippet').serializeArray(), dataType: 'html')
    .done (data) ->
      $('#preview .article-content').html(data);
  $('input[name="tab"]').on 'change', (event) ->
    $($(event.target).data('selector')).addClass 'active'
    $('input[name="tab"]:not(:checked)').each ->
      $($(this).data('selector')).removeClass 'active'

((w, d) ->
  s = undefined
  e = d.getElementsByTagName("script")[0]
  a = (u, i) ->
    unless d.getElementById(i)
      s = d.createElement("script")
      s.src = u
      s.id = i  if i
      e.parentNode.insertBefore s, e

  a "https://apis.google.com/js/plusone.js"
  a "//b.st-hatena.com/js/bookmark_button_wo_al.js"
  a "//platform.twitter.com/widgets.js", "twitter-wjs"
  a "//connect.facebook.net/ja_JP/all.js#xfbml=1", "facebook-jssdk"
) this, document
