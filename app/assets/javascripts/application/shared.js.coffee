window.starterkitrails = window.starterkitrails or {}
((shared, $) ->

  shared.init = (scrollTo) ->
    shared.initFlashNotice(10000)

  shared.initFlashNotice = (display_for_seconds) ->
      if $('.flash-container').length != 0
        setTimeout ->
          $('.flash-container').slideUp()
        , display_for_seconds

) window.starterkitrails.shared = window.starterkitrails.shared or {}, jQuery
