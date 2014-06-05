AirAware.Views.Readings ||= {}

class AirAware.Views.Readings.Block extends Backbone.Epoxy.View
  template: JST["templates/readings/block"]
  className: ""

  bindings: {
    "span.pm2p5"      : "text:disp_pm2p5"
    "span.temperature": "text:disp_temperature"
    "span.humidity"   : "text:disp_pm2p5"
    "span.tvoc"       : "text:disp_pm2p5"
    "span.hcho"       : "text:disp_hcho"
    "span.co2"        : "text:disp_co2"
  }

  render: () ->
    this.$el.html(this.template(model: @model));
    @applyBindings()
    return this;
