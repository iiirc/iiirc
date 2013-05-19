$ ->
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
