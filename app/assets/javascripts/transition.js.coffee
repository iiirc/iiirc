$ ->
  href = $("#transition").attr("href")
  if href then setTimeout (-> location.href = href), 12000
