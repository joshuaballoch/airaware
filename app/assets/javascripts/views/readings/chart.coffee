AirAware.Views.Readings ||= {}

class AirAware.Views.Readings.Chart extends Backbone.View
  template: JST["templates/readings/chart"]

  display_data_options: [
    {display_data: "pm2p5", label: __("P.M. 2.5")},
    {display_data: "humidity", label: __("Humidity")},
    {display_data: "tvoc", label: __("TVOC")},
    # {display_data: "hcho", label: __("Formaldehyde")},
    {display_data: "co2", label: __("CO2")},
    {display_data: "temperature", label: __("Temperature")}
  ]

  initialize: (options) ->
    $target = options.target
    @chart_options = {}
    @devices = $target.data('devices')
    @display_data = $target.data('display-data')
    @display_data_options = _.filter @display_data_options, (option) => return @display_data[option.display_data]
    @chart_options.outdoor_location = $target.data('outdoor-location')
    @chart_options.device_id = @devices[0].id

  events:
    "change select.device":"onSelectDevice"
    "change select.reading-data":"onSelectData"

  render: () ->
    this.$el.html(this.template({devices: @devices, display_data_options: @display_data_options}))
    @renderChart()
    return this;

  renderChart: () ->
    $aa_chart = @$el.find('.aa-chart')
    $aa_chart.data('chart').close() if $aa_chart.data('chart')
    $aa_chart.aaChart(_.extend({},@chart_options))

  onSelectDevice: (event) ->
    $target = $(event.currentTarget)
    @chart_options.device_id = _.find(@devices, (device) -> device.id == parseInt($target.val()) ).id
    @renderChart()

  onSelectData: (event) ->
    $target = $(event.currentTarget)
    if @display_data[$target.val()]
      @chart_options.display_data = $target.val()
      @renderChart()
