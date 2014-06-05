$.fn.dynamizeReadingBlock = () ->
  $target = $(this)

  # Collect the necessary data from the target
  options = {}
  options.location_id = $target.data('location-id')
  # TO DO: implement it as a DEVICE ID reading fetch..
  # options.device_id   = $target.data('device-id')
  options.url = "/locations/#{options.location_id}/readings/latest"

  # Get the current reading
  model = new AirAware.Models.Reading

  # Fetch the first reading and show the reading block
  model.fetch({url: options.url}).success () =>
    view = new AirAware.Views.Readings.Block model: model
    $target.html(view.render().el)

  # Poll for new readings
  setInterval () ->
    model.fetch({url: options.url})
    console.log "fetching for lcoation #{options.location_id}"
  , 3000

