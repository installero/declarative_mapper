require 'csv'
require 'yaml'

require 'declarative_mapper'

describe DeclarativeMapper do
  describe '.parse' do
    before do
      client_mapper_methods_dir_path = "#{__dir__}/fixtures/reliable"

      Dir["#{client_mapper_methods_dir_path}/**/*.rb"].each { |file| require file }
    end

    let(:yml_content) do
      yml_path = "#{__dir__}/fixtures/reliable/customers.yml"

      YAML.load_file(yml_path).deep_symbolize_keys[:mapping]
    end

    let(:csv_table) do
      csv_path = "#{__dir__}/fixtures/reliable/accounts.csv"

      CSV.parse(File.read(csv_path), headers: true)
    end

    let(:first_csv_row) { csv_table.first }
    let(:fourth_csv_row) { csv_table[3] }

    let(:mapper_methods) { Reliable::MapperMethods::Customers }

    let(:result1) do
      DeclarativeMapper.convert(mapper_methods, yml_content, first_csv_row)
    end

    let(:result4) do
      DeclarativeMapper.convert(mapper_methods, yml_content, fourth_csv_row)
    end

    it 'reads the csv file' do
      expect(first_csv_row['accountnum']).to eq '23040'
    end

    it 'reads the yml file' do
      expect(yml_content[:account_number]).to eq 'accountnum'
    end

    it 'parses simple yml fields' do
      expect(result1[:account_number]).to eq '23040'
    end

    it 'requires methods from separate files & applies them' do
      expect(result1[:active]).to eq true
    end

    it 'passes multiple args to method' do
      expect(result1[:name]).to eq 'FUNDANCE GROUP OF MONTANA LLC'
    end

    it 'normalizes phone number' do
      expect(result4[:billing_phone]).to eq '+612-243-5251'
    end

    it 'sets default value for country' do
      expect(result1[:billing_country]).to eq 'United States'
    end

    it 'sets nested attributes for address' do
      expect(result1[:address_attributes][:street]).to eq '527 Derbyshire '
    end

    it 'requires method from nested module for nested attributes for address' do
      expect(result1[:address_attributes][:phone_kind]).to eq 'Nice phone'
    end

    it 'requires method from nested module for even more deeply nested attributes for address phone' do
      expect(result1[:address_attributes][:phone_attributes][:code]).to eq '+1'
    end

    it 'uses shared us method for address attributes country' do
      expect(result1[:address_attributes][:country]).to eq 'United States'
    end

    it 'allows capital letters and spaces in cvs table names' do
      expect(result1[:branch_name]).to eq 'Reliable Exterminators'
    end

    it 'supports attributes arrays' do
      expect(result1[:contacts_attributes].first[:title]).to eq '        FUNDANCE GROUP OF MONTANA LLC'
    end
  end
end
