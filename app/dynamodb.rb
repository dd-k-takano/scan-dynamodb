require 'aws-sdk'

class DynamoDB
  def initialize
    @dynamodb = Aws::DynamoDB::Client.new
  end

  def read(params)
    scan(params)
  rescue Aws::DynamoDB::Errors::ServiceError => e
    puts 'Unable to scan:'
    puts e.message.to_s
  end

  private

  attr_accessor :dynamodb

  def scan(params)
    results = []
    loop do
      result = dynamodb.scan(params)
      result.items.each { |item| results.push(item) }
      break if result.last_evaluated_key.nil?

      puts 'Get ' + result.items.size.to_s + ' and Scanning for more...'
      params[:exclusive_start_key] = result.last_evaluated_key
    end
    results
  end
end
