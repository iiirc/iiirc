$ ->
  $('input[readonly="readonly"]').focus (event) ->
    $(event.target).select()
  .click (event) ->
    $(event.target).select()

  $('a[data-method="post"]').on "ajax:success", (data, status, xhr) ->
    $(@).closest("p").find(".count").text status.count
