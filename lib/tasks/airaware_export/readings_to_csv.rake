## USAGE
#  rake airaware:export:readings_to_csv device_id=1 from_time="2014-05-12 17:00:00" to_time="2014-05-12 18:00:00" export_dir="/Users/joshuaballoch/tmp"

require 'csv'

namespace :airaware do
  namespace :export do
    desc "export readings data to csv file(s)"
    task :readings_to_csv => :environment do
      puts ENV['device_id']
      puts ENV['export_dir']
      if ENV['device_ids']
        device_ids = ENV['device_ids']
      else
        device_ids = [ENV['device_id']]
      end

      ReportingDevice.where(:id => device_ids).each do |r|
        readings_to_print = r.readings.ordered.where('reading_time > ?',  DateTime.from_str(ENV['from_time'])).where('reading_time < ?', DateTime.from_str(ENV['to_time']))
        puts "count: #{readings_to_print.count}"
        CSV.open("#{ENV['export_dir']}/#{r.device_type_humanize}_#{r.identifier}.csv", 'w') do |csv|
          # put the header
          csv << ["Reporting Device Id", "Reporting Device Identifier", "Reporting Device Type", "Reading ID", "Reading Time", "Temperature", "Humidity", "HCHO", "CO2", "CO", "TVOC", "PM2.5"]
          # put all the readings
          readings_to_print.all.each do |reading|
            csv << [reading.reporting_device_id, reading.reporting_device.identifier, reading.reporting_device.device_type_humanize, reading.id, reading.reading_time, reading.temperature, reading.humidity, reading.hcho, reading.co2, reading.co, reading.tvoc, reading.pm2p5]
          end
        end
      end

    end
  end
end
