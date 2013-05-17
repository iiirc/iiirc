$ ->
  $('input[readonly="readonly"]').focus (event) ->
    $(event.target).select()
  .click (event) ->
    $(event.target).select()

  $('a[data-method="post"]').on "ajax:success", (data, status, xhr) ->
    $container = $(@).closest("p")
    $container.find(".count").text status.count
    if $container.find("img[data-user-id='#{status.user_id}']").length == 0
      $container.find(".starred-by").append("<img src='#{status.user.gravatar_url}' alt='Starred by #{status.user.username}' data-user-id='#{status.user_id}'>")
  .on "ajax:error", (xhr, status, error) ->
    status = $.parseJSON(status.responseText)
    msg = status.errors || "Error!"
    alert msg

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
