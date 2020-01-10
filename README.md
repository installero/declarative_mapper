# Installation

Install a gem

``` rb
gem 'declarative_mapper'
```

``` sh
bundle install
```

or

``` sh
gem install declarative_mapper
```

# Usage

```
require 'declarative_mapper`
require 'csv'
require 'yaml'

require_relative 'lib/declarative_mapper'

Dir["reliable/**/*.rb"].each { |file| require_relative file }

csv_path = "#{__dir__}/reliable/accounts.csv"
csv_table = CSV.parse(File.read(csv_path), headers: true)
csv_row = csv_table.first

yml_path = "#{__dir__}/reliable/customers.yml"
yml_content = YAML.load_file(yml_path).deep_symbolize_keys

mapper_methods = Reliable::MapperMethods::Customers

customer_attrs = DeclarativeMapper.convert(mapper_methods, yml_content[:mapping], csv_row)

puts customer_attrs.inspect
```
