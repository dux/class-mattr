version  = File.read File.expand_path '.version', File.dirname(__FILE__)
gem_name = 'class-mattr'

Gem::Specification.new gem_name, version do |gem|
  gem.summary     = 'Ruby method attributes'
  gem.description = 'Mothod attributes are not natively supported by ruby, this fixes the problem!'
  gem.authors     = ["Dino Reic"]
  gem.email       = 'reic.dino@gmail.com'
  gem.files       = Dir['./lib/**/*.rb']+['./.version']
  gem.homepage    = 'https://github.com/dux/%s' % gem_name
  gem.license     = 'MIT'
end