$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xygon'

def read_with_ascii(filename)
  open(filename).read.force_encoding("ascii-8bit").strip
end
