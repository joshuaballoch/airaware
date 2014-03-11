
class AirAware.Models.Reading extends Backbone.Model
  paramRoot: "reading"
  urlRoot: "/readings"

class AirAware.Collections.Readings extends Backbone.Collection
  model: AirAware.Models.Reading

  initialize: (models, options) ->
    throw "Error: Cannot initialize Readings collection without a location id.." unless options?.location_id
    @location_id = options.location_id

  url: () ->
    return "/locations/#{@location_id}/readings"
