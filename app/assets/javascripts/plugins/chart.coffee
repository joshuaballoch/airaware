prepChartData = (readings) ->
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

  data = {
    labels : times,
    datasets : [
      {
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : pm2p5
      }
    ]
  }

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
  options.location_id = $target.data('location-id')
  # TO DO: implement it as a DEVICE ID reading fetch..
  # options.device_id   = $target.data('device-id')
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
  readings = new AirAware.Collections.Readings([], {location_id: options.location_id})

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
