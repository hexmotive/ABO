require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('ABO', '0.0.2') do |p|
  p.description    = "RUBY ABO banking format library"
  p.url            = "http://github.com/hexmotive/ABO"
  p.author         = "Josef Šimánek"
  p.email          = "retro@ballgag.cz"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
