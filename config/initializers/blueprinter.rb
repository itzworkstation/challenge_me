require 'yajl' # you can skip this if yajl has already been required.

Blueprinter.configure do |config|
  config.generator = Yajl::Encoder # default is JSON
  config.method = :encode # default is generate
end