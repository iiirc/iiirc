$ ->
  href = $('#transition').attr('href')
  if href
    remaining = 12
    container = $('#remaining-time')
    setInterval ->
      remaining--
      container.text remaining
      if remaining == 0 then location.href = href
    , 1000
