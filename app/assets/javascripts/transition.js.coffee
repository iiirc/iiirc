$ ->
  if $('#page_transition_show').is(':visible')
    $('body').css({
      backgroundColor: '#fff',
      color: '#2b2b2b'
    })
    href = $('#transition').attr('href')
    if href
      $container = $('#remaining-time')
      remaining = parseInt($container.text())
      timer = setInterval ->
        remaining--
        $container.text remaining
        if remaining == 0
          clearInterval timer
          location.href = href
      , 1000
