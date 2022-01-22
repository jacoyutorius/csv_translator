# frozen_string_literal: true

# Translate CSV
class CsvTranslator
  require 'open-uri'
  require 'csv'
  require 'aws-sdk-translate'

  def initialize(csv_url, target_columns)
    @csv_url = csv_url
    @target_columns = target_columns
  end

  def run!(source_language_code, target_language_code)
    filename = "#{target_language_code}.csv"
    write_csv(filename, generate_translated_data(source_language_code, target_language_code))
    filename
  end

  private

  SEPARATOR = '|'

  def generate_translated_data(source_language_code, target_language_code)
    csv.map do |row|
      text = @target_columns.inject('') { |str, i| str += row[i].to_s + SEPARATOR } # rubocop:disable Lint/UselessAssignment
      translate_text_response = translate_text(text, source_language_code, target_language_code)
      translated = translate_text_response.translated_text.split(SEPARATOR)

      @target_columns.each do |i|
        row[i] = translated.shift
      end

      row
    end
  end

  def write_csv(filename, csv_data)
    CSV.open(filename, 'wb') do |csv|
      csv_data.each do |row|
        csv << row
      end
    end
  end

  def csv
    @csv ||= CSV.table(URI.open(@csv_url), headers: false, row_sep: "\r\n") # rubocop:disable Security/Open
  end

  def aws_client
    @aws_client ||= Aws::Translate::Client.new
  end

  def translate_text(text, source_language_code, target_language_code)
    aws_client.translate_text({
                                text: text,
                                source_language_code: source_language_code,
                                target_language_code: target_language_code
                              })
  end
end
