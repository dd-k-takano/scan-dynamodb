require './app/dynamodb'
require './app/export'

platform = DynamoDB.new.read({ table_name: ENV['TABLE_NAME'] })
Export.new(platform).csv(ENV['CSV_NAME'])
