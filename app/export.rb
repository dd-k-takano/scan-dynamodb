require 'csv'

class Export
  def initialize(data)
    @data = data
    puts data.size
  end

  def csv(path)
    CSV.open(path, 'w') do |csv|
      data.each do |d|
        csv << hash_to_csv(d)
      end
    end
  end

  def debug; end

  private

  attr_accessor :data

  def hash_to_csv(hash)
    result = []
    hash.keys.each do |key|
      result.push(hash[key].instance_of?(BigDecimal) ? hash[key].to_i : hash[key].to_s.strip)
    end
    result
  end
end
