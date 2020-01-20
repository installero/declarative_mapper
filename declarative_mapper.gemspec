Gem::Specification.new do |spec|
  spec.name = 'declarative_mapper'
  spec.version = '0.1.0'
  spec.date = '2019-12-24'
  spec.summary = 'Creates an object from a csv row according to yml-file with mapping rules'
  spec.authors = ['Ivan Nemytchenko', 'Vadim Venediktov']
  spec.email = 'install.vv@gmail.com'
  spec.homepage = 'https://gitlab.com/installero/sync_prototype'
  spec.license = 'MIT'

  spec.files = [
    'lib/declarative_mapper.rb',
  ]
  spec.files += Dir['lib/*.rb']
  spec.files += Dir['templates/*.erb']

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport'
end
