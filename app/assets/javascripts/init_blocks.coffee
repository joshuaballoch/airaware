$(document).ready () ->
  _.each $('.aa-reading-block'), (item) ->
    $(item).dynamizeReadingBlock()

  _.each $('.aa-outdoor-reading-block'), (item) ->
    $(item).dynamizeOutdoorReadingBlock()
