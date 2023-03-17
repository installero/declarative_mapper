Gem::Specification.new do |spec|
  spec.name = 'declarative_mapper'
  spec.version = '0.1.1'
  spec.date = '2021-06-19'
  spec.summary = 'Creates an object from a csv row according to yml-file with mapping rules'
  spec.authors = ['Ivan Nemytchenko', 'Vadim Venediktov']
  spec.email = 'install.vv@gmail.com'
  spec.homepage = 'https://github.com/installero/declarative_mapper'
  spec.license = 'MIT'

  spec.files = [
    'lib/declarative_mapper.rb',
  ]
  spec.files += Dir['lib/*.rb']
  spec.files += Dir['templates/*.erb']

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 1', '< 8'
end
