require 'active_support/core_ext/hash/keys.rb'
require 'active_support/core_ext/string'

class DeclarativeMapper
  def self.convert(mapper_methods, mapping_hash, csv_row)
    deep_transform_values_with_path(mapping_hash) do |csv_field_name, path|
      field_name = path.last

      if needs_method?(csv_field_name)
        parsed_signature =
          parse_signature(csv_field_name, field_name)

        args = argument_values(parsed_signature[:arguments], csv_row)
        method_name = parsed_signature[:method_name]

        unless shared_method?(csv_field_name)
          method_name = path[0..-2].push(method_name).join('_')
        end

        mapper_methods.send(method_name, *args)
      else
        csv_row[csv_field_name]
      end
    end
  end

  def self.required_csv_fields(mapping_hash)
    deep_inject(mapping_hash, []) do |value, sum|
      if needs_method?(value)
        sum += (parse_signature(value)[:arguments])
      else
        sum.push(value)
      end
    end.uniq.compact
  end

  def self.argument_values(argument_names, csv_row)
    argument_names.map { |name| csv_row[name] }
  end

  def self.parse_signature(signature, field_name=nil)
    match = signature.match(/^(.*)\((.*)\)/)

    method_name = match[1]
    method_name = field_name if method_name.empty?

    {
      arguments: match[2].gsub(/,\s+/, ',').split(','),
      method_name: method_name
    }
  end

  def self.shared_method?(signature)
    !!(signature =~ /^.+\(.*\)/)
  end

  def self.needs_method?(signature)
    !!(signature =~ /\(.*\)/)
  end

  # Example of usage:
  #
  # my_hash = {a: 0, b: {c: 1, d: 2, e: {f: 3}}}
  # values = %w(mother washed the ceiling)
  #
  # result = deep_transform_values_with_path(my_hash) do |value, path|
  #   path.join('/') + '/' + values[value]
  # end
  #
  # {:a=>"a/mother", :b=>{:c=>"b/c/washed", :d=>"b/d/the", :e=>{:f=>"b/e/f/ceiling"}}}
  #
  def self.deep_transform_values_with_path(object, path=[], &block)
    case object
    when Hash
      object.map { |k, v| [k, deep_transform_values_with_path(v, path + [k], &block)] }.to_h
    when Array
      object.map { |e| deep_transform_values_with_path(e, path, &block) }
    else
      yield(object, path)
    end
  end

  def self.deep_inject(object, acc, &block)
    case object
    when Hash
      object.inject(acc) { |a, (k, v)| deep_inject(v, a, &block) }
    when Array
      object.inject(acc) { |a, e| deep_inject(e, a, &block) }
    else
      yield(object, acc)
    end
  end
end
