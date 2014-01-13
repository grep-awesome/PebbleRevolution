require 'FileUtils'
items = Dir.glob File.join(File.dirname(__FILE__), 'release_configs', '*.conf')
items.each do |item|
	name_parts = File.basename(item).split('.')
	name_parts.pop
	name = name_parts.join('.')

	puts "Building #{name} release"
	conf = File.read(item)

	File.open File.join(File.dirname(__FILE__), 'src', 'qt_config.h'), 'w' do |f|
		f.write conf
	end

	`pebble build`
	new_name = "Revolution-2.1-QTP-" + name + ".pbw"	
	FileUtils.copy File.join(File.dirname(__FILE__), 'build', 'PebbleRevolution.pbw'), File.join(File.dirname(__FILE__), 'releases', new_name)
end
