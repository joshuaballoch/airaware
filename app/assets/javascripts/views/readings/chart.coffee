AirAware.Views.Readings ||= {}

class AirAware.Views.Readings.Chart extends Backbone.View
  template: JST["templates/readings/chart"]

  initialize: (options) ->
    $target = options.target
    @chart_options = {}
    @devices = $target.data('devices')
    @chart_options.outdoor_location = $target.data('outdoor-location')
    @chart_options.device_id = @devices[0].id

  events:
    "change select.device":"onSelectDevice"

  render: () ->
    this.$el.html(this.template({devices: @devices}))
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
