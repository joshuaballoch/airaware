AirAware.Views.Readings ||= {}

class AirAware.Views.Readings.Block extends Backbone.Epoxy.View
  template: JST["templates/readings/block"]
  className: ""

  bindings: {
    "span.pm2p5"            : "text:disp_pm2p5"
    "span.pm2p5-badge"      : "html:pm2p5_rating"
    "span.temperature"      : "text:disp_temperature"
    # "span.temperature-badge": "html:temperature_rating"
    "span.humidity"         : "text:disp_humidity"
    "span.humidity-badge"   : "html:humidity_rating"
    "span.tvoc"             : "text:disp_tvoc"
    "span.tvoc-badge"       : "html:tvoc_rating"
    "span.hcho"             : "text:disp_hcho"
    "span.hcho-badge"       : "html:hcho_rating"
    "span.co2"              : "text:disp_co2"
    "span.co2-badge"        : "html:co2_rating"
    "span.readingtime"      : "text:disp_reading_time"
  }

  computeds: {
    "pm2p5_rating"      : () ->
      "<span class='badge #{AirAware.assessAirClass(@getBinding('pm2p5'))}' >ah!</span>"
    "humidity_rating"   : () ->
      "<span class='badge #{AirAware.assessHumidityClass(@getBinding('humidity'))}' >ah!</span>"
    "tvoc_rating"       : () ->
      "<span class='badge #{AirAware.assessTvocClass(@getBinding('tvoc'))}' >ah!</span>"
    "hcho_rating"       : () ->
      "<span class='badge #{AirAware.assessHchoClass(@getBinding('hcho'))}' >ah!</span>"
    "co2_rating"        : () ->
      "<span class='badge #{AirAware.assessCo2Class(@getBinding('co2'))}' >ah!</span>"
  }

  render: () ->
    this.$el.html(this.template(model: @model));
    @applyBindings()
    return this;
