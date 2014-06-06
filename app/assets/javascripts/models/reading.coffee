
class AirAware.Models.Reading extends Backbone.Epoxy.Model
  paramRoot: "reading"
  urlRoot: "/readings"

  computeds:
    disp_pm2p5:
      deps: ["pm2p5"]
      get: (pm2p5) ->
        return "N/A" if pm2p5 <= 0
        parseInt(pm2p5)

    disp_temperature:
      deps: ["temperature"]
      get: (temperature) ->
        parseInt(temperature) || "N/A"

    disp_humidity:
      deps: ["humidity"]
      get: (humidity) ->
        parseInt(humidity) || "N/A"

    disp_tvoc:
      deps: ["tvoc"]
      get: (tvoc) ->
        AirAware.precise_round(parseFloat(tvoc),2) || "<0.1"

    disp_hcho:
      deps: ["hcho"]
      get: (hcho) ->
        AirAware.precise_round(hcho,2) || "N/A"

    disp_co2:
      deps: ["co2"]
      get: (co2) ->
        parseInt(co2) || "N/A"

    disp_reading_time:
      deps: ["reading_time"]
      get: (reading_time) ->
        AirAware.parseTime(reading_time) if reading_time

class AirAware.Collections.Readings extends Backbone.Collection
  model: AirAware.Models.Reading

  initialize: (models, options) ->
    throw "Error: Cannot initialize Readings collection without a location id.." unless options?.location_id
    @location_id = options.location_id

  url: () ->
    return "/locations/#{@location_id}/readings"
