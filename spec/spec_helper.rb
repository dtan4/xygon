$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xygon'

def read_as_binary(filename)
  open(filename, "rb").read.strip
end
