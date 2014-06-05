AirAware.Views.Readings ||= {}

class AirAware.Views.Readings.Block extends Backbone.View
  template: JST["templates/readings/block"]
  className: ""
  render: () ->
    this.$el.html(this.template(model: @model));
    return this;
