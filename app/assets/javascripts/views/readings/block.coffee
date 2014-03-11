AirAware.Views.Readings ||= {}

class AirAware.Views.Readings.Block extends Backbone.View
  template: JST["templates/readings/block"]
  className: "row"
  render: () ->
    this.$el.html(this.template(model: @model));
    return this;
