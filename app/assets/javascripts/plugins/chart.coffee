class ReadingsChart
  reference_data:
    pm2p5: [
          {value: 200, level: 5, rating: "very-unhealthy"},
          {value: 120, level: 4, rating: "unhealthy"},
          {value: 100, level: 3, rating: "sensitive"},
          {value: 75,  level: 2, rating:  "moderate"},
          {value: 35,  level: 1, rating:  "good"},
          ]

  constructor: (options) ->
    @namespace = _.uniqueId()
    @options = options
    @options.base_html ||= () =>
      """
        <canvas class="chart" width="#{options.width_reference.width()}" height="400"></canvas>
      """

    @options.find_ctx = () =>
      $canvas = @options.target.find('canvas')
      unless $canvas.get(0).getContext
        G_vmlCanvasManager.initElement($canvas.get(0))
      $canvas.get(0).getContext("2d");

    @readings = new AirAware.Collections.Readings([], {device_id: options.device_id})

    # # Fetch the first readings and show the chart
    @readings.fetch().success () =>
      @setChart()

    # Poll for new readings
    @pollInterval = setInterval () =>
      @readings.fetch().success () =>
        @setChart()
    , 30000

    throttled_set_chart = _.throttle @setChart, 500

    $(window).on "resize.#{@namespace}", () =>
      throttled_set_chart.call(@)

  prepChartData: (readings) ->
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

    display_ratings = _.filter @reference_data.pm2p5, (item) -> return item.value < max

    display_ratings.unshift _.find(@reference_data.pm2p5, (item) -> return item.level == (1 + _.max(display_ratings, (rating) -> rating.level).level))

    _.each display_ratings, (rating) ->
      colour = $(".rating-colour.#{rating.rating}").css("background-color")
      # Change colour opacity
      unless AirAware.ie() && AirAware.ie() < 9
        colour = "rgba#{colour.substr(3).slice(0,-1)},0.1)"
      a = {
            fillColor: colour,
            strokeColor: colour,
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

  setChart: () ->
    # Prep the data
    opts = @prepChartData(@readings)

    # Add the chart again
    @options.target.html(_.template(@options.base_html()))

    # Find the ctx
    ctx = @options.find_ctx()

    # Add the chart
    myChart = new Chart(ctx).Line(opts.data, opts.options);

  close: () ->
    clearInterval(@pollInterval)
    $(window).off("resize.#{@namespace}")
    @options.target.html("")

$.fn.aaChart = (options) ->
  $target = $(this)
  options.target = $target

  # Add more options
  options.width_reference = $(".container > .row > .col-sm-12")

  chart = new ReadingsChart(options)
  $target.data('chart', chart)

$.fn.dynamizeChart = () ->
  $target = $(this)
  view = new AirAware.Views.Readings.Chart target: $target
  $target.html(view.render().el)
