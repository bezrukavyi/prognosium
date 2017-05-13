$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'prognosium'
Dir[("#{Dir.pwd}/spec/support/**/*.rb")].each { |file| require file }
