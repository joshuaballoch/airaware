getReadings = (model) ->
  dfd = $.Deferred()

  payload = {
    url: "/readings/us_consulate.xml",
    dataType: 'xml',
    type: 'get',
    data:
      city: model.get('city')
  };
  $.ajax(payload).success (data) ->
    response = $.xml2json(data)

    ## Parse the Received Data
    #  collect the general data
    air_data = response.channel.item
    last_reading = air_data[0]

    #  parse the reading time
    time_arr = last_reading.ReadingDateTime.match(/(\d{2})\/(\d{2})\/(\d{4}) (\d{1,2}):(\d{2}):(\d{2}) ([\D]{2})/)
    hours = time_arr[4]
    midi = time_arr[7]
    if midi == "PM" && parseInt(hours) != 12
      hours = "#{parseInt(hours)+12}"
    else if parseInt(hours) == 12
      hours == "00"
    hours = if "#{hours}".length < 2 then "0#{hours}" else "#{hours}"

    parsedTime = "#{time_arr[3]}-#{time_arr[1]}-#{time_arr[2]}T#{hours}:#{time_arr[5]}:#{time_arr[6]}Z"

    # Set the model
    model.set({pm2p5: last_reading.Conc, reading_time: parsedTime})

    # Let others know it is fine
    dfd.resolve(data)
  .fail (response) ->
    # Let others know it failed
    dfd.reject(response)

  return dfd.promise()

$.fn.dynamizeOutdoorReadingBlock = () ->
  $target = $(this)

  # Collect the necessary data from the target
  options = {}
  options.location = $target.data('location')

  # Get the current reading
  model = new AirAware.Models.Reading({usdata: true, city: options.location})

  # Fetch the first reading and show the reading block
  getReadings(model).done () =>
    view = new AirAware.Views.Readings.Block model: model
    $target.html(view.render().el)

  # Poll for new readings
  uniqid = _.uniqueId()
  setInterval () ->
    getReadings(model)
    # if window.console
    #   console.log "fetching uniqid #{uniqid} for lcoation #{options.location}"
  , 3000
