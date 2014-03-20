//= require jquery

jQuery ($)->
  $('.js-switch-locale').on 'click', ->
    locale = $(this).data('locale')
    pathname = location.pathname
    query = location.search

    if pathname.substring(0, 3) == '/en' or pathname.substring(0, 3) == '/zh'
      pathname = pathname.substring(3)
    if pathname == ""
      pathname = '/'

    query = query.replace(/([&?])locale=(en|zh)&/, "$1").replace(/([&?])locale=(en|zh)$/, "$1")
    query = '?' if query == ''
    query += '&' if query.slice(-1) != '?' and query.slice(-1) != '&'
    query += "locale=#{locale}"
    window.location = pathname + query

