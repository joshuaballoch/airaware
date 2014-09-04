$.fn.dynamizeReadingBlock = () ->
  $target = $(this)

  # Collect the necessary data from the target
  options = {}
  # options.location_id = $target.data('location-id')
  # TO DO: implement it as a DEVICE ID reading fetch..
  options.device_id   = $target.data('device-id')
  options.device_label = $target.data('device-label')

  options.display_data = $target.data('display-data')

  options.url = "/reporting_devices/#{options.device_id}/readings/latest"

  # Get the current reading
  model = new AirAware.Models.Reading

  model.simple = $target.data('simple')

  if options.display_data
    _.each ["temperature", "humidity", "hcho", "co2", "tvoc", "pm2p5"], (reading_type) ->
      model["display_#{reading_type}"] = options.display_data[reading_type]

  # Fetch the first reading and show the reading block
  model.fetch({url: options.url}).success () =>
    view = new AirAware.Views.Readings.Block model: model, device_label: options.device_label, device_id: options.device_id
    $target.html(view.render().el)

  # Poll for new readings
  setInterval () ->
    model.fetch({url: options.url})
    # if window.console
    #   console.log "fetching for lcoation #{options.location_id}"
  , 60000

