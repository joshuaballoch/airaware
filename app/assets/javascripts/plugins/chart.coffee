ReferenceData = {
  pm2p5: [
        {value: 200, level: 5, rating: "very-unhealthy"},
        {value: 120, level: 4, rating: "unhealthy"},
        {value: 100, level: 3, rating: "sensitive"},
        {value: 75,  level: 2, rating:  "moderate"},
        {value: 35,  level: 1, rating:  "good"},
        ]
}

prepChartData = (readings) ->
  # Parse the times from the indoor air
  times = _.map readings.models, (item) ->
    return item.get('reading_time');
  _.each times, (item, index) ->
    if parseInt(index/5)*5 == index
      time = AirAware.parseTime(item)
      times[index] = time.substring(0,time.length-3)
    else
      times[index] = ""
  pm2p5 = _.map readings.models, (item) ->
    return item.get('pm2p5');

  times.reverse()
  pm2p5.reverse()

  options = {
    animation: false,
    scaleOverride: true,
    scaleSteps : 10,
    #Number - The value jump in the hard coded scale
    scaleStepWidth : 10*Math.ceil(0.1*Math.ceil(_.max(pm2p5)/7.5)),
    #Number - The scale starting value
    scaleStartValue : 0,
    pointDot: false,
  }
  datasets = [
  ]

  # Set the background labels
  max = options.scaleStepWidth*options.scaleSteps

  display_ratings = _.filter ReferenceData.pm2p5, (item) -> return item.value < max

  display_ratings.unshift _.find(ReferenceData.pm2p5, (item) -> return item.level == (1 + _.max(display_ratings, (rating) -> rating.level).level))

  _.each display_ratings, (rating) ->
    colour = $(".rating-colour.#{rating.rating}").css("background-color")
    # Change colour opacity
    colour = "rgba#{colour.substr(3).slice(0,-1)},0.1)"
    a = {
          fillColor: colour
          data: _.map(times, () -> return rating.value)
        }
    datasets.push a

  # if there is a city, add the outdoor data

  # Add the indoor data
  datasets.push {
      fillColor : "rgba(151,187,205,0.6)",
      strokeColor : "rgba(220,220,220,1)",
      pointColor : "rgba(220,220,220,1)",
      pointStrokeColor : "#fff",
      data : pm2p5
    }

  _.each times, (item, index) ->

  data = {
    labels : times,
    datasets : datasets
  }


  return {data: data, options: options}

setChart = (readings, options) ->
  # Prep the data
  opts = prepChartData(readings)

  # Add the chart again
  options.target.html(_.template(options.base_html()))

  # Find the ctx
  ctx = options.find_ctx()

  # Add the chart
  myChart = new Chart(ctx).Line(opts.data, opts.options);

$.fn.dynamizeChart = () ->
  $target = $(this)

  # Collect the necessary data from the target
  options = {}
  options.target = $target
  options.devices = $target.data('devices')
  options.outdoor_location = $target.data('outdoor-location')

  options.device_id = options.devices[0].id

  options.width_reference = $(".container > .row > .col-sm-12")
  options.base_html = () =>
    """
      <div class="skin"></div>
      <div class="aa-block-inner">
        <div class="aa-block-title">
          <h3><%= __("Trending Outlook - PM 2.5") %></h3>
        </div>
        <div class="aa-block-body">
          <canvas class="chart" width="#{options.width_reference.width()}" height="400"></canvas>
        </div>
      </div>
    """
  options.find_ctx = () =>
    $canvas = options.target.find('canvas')
    unless $canvas.get(0).getContext
      G_vmlCanvasManager.initElement($canvas.get(0))
    $canvas.get(0).getContext("2d");

  # Initialize the collection
  readings = new AirAware.Collections.Readings([], {device_id: options.device_id})

  # Fetch the first readings and show the chart
  readings.fetch().success () =>
    setChart(readings, options)

  # Poll for new readings
  setInterval () ->
    readings.fetch().success () =>
      setChart(readings, options)
  , 30000

  throttled_set_chart = _.throttle setChart, 500

  $(window).on "resize", () ->
    throttled_set_chart(readings, options)
