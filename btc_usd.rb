require 'rubygems'
require 'rest_client'
require 'json'
require 'erb'

@price = JSON.parse(RestClient.get("http://bitcoincharts.com/t/weighted_prices.json"))["USD"]["24h"]

File.open(File.expand_path(File.dirname(__FILE__)) + "/public/index.html", "w") do |file|
  file.puts ERB.new(File.read(File.expand_path(File.dirname(__FILE__)) + "/template.erb")).result(binding)
end

