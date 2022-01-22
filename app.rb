require 'aws-sdk-translate'
# require 'open-uri'
# require 'csv'

# csv_url = ARGV.shift
# target_columns = ARGV.map(&:to_i)
# csv = CSV.table(URI.open(csv_url), headers: false, row_sep: "\r\n")

# csv.each do |row|
#   p target_columns.inject("") {|str, i| str += row[i].to_s + "|" }
# end

class CsvTranslator
  require 'open-uri'
  require 'csv'
  require 'aws-sdk-translate'

  def initialize(csv_url, target_columns)
    @csv_url = csv_url
    @target_columns = target_columns
  end

  def run!(target_language_code='en')
    write_csv("#{target_language_code}.csv", generate_translated_data)
  end

  private

  def generate_translated_data
    csv.map do |row|
      text = @target_columns.inject("") {|str, i| str += row[i].to_s + '|' }
      translateTextResponse = translate_text(text)
      translated = translateTextResponse.translated_text.split('|')

      # ar_en = row.dup
      @target_columns.each do |i|
        row[i] = translated.shift
      end

      row
    end
  end

  def write_csv(filename, csv_data)
    CSV.open('en.csv', 'wb') do |csv|
      csv_data.each do |row|
        csv << row
      end
    end
  end

  def csv
    @csv ||= CSV.table(URI.open(@csv_url), headers: false, row_sep: "\r\n")
  end

  def aws_client
    @aws_client ||= Aws::Translate::Client.new
  end

  def translate_text(text, source_language_code='ja', target_language_code='en')
    aws_client.translate_text({
      text: text,
      source_language_code: "ja",
      target_language_code: "en",
    })
  end
end

csv_url = ARGV.shift
target_columns = ARGV.map(&:to_i)
translator = CsvTranslator.new(csv_url, target_columns)
p translator.run!