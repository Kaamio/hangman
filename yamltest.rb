class Yamltesti
	require "yaml"

def initialize
@age = "12"
@name = "pekka"
end

end

pekka = Yamltesti.new

File.open("yamltest.txt", "w") do |f|
f.puts pekka.to_yaml
end
puts pekka

