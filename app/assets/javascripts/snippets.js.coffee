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
