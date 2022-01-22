# frozen_string_literal: true

require './libs/csv_translator'

raise 'no aruments specified' if ARGV.length.zero?

csv_url = ARGV.shift
target_columns = ARGV.map(&:to_i)
translator = CsvTranslator.new(csv_url, target_columns)
p translator.run!('ja', 'en')
