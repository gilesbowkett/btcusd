%w{rubygems rest_client json erb}.each {|lib| require lib}

class File
  class << self
    def here(path)
      expand_path(dirname(__FILE__)) + path
    end
  end
end

@price = JSON.parse(RestClient.get("http://bitcoincharts.com/t/weighted_prices.json"))["USD"]["24h"]

File.open(File.here("/public/index.html"), "w") do |file|
  file.puts ERB.new(File.read(File.here("/template.erb"))).result(binding)
end

if File.new(File.here("/public/index.html")).stat.zero?
  system("cp error_page.html public/index.html")
end

