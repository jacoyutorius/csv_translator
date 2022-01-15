require 'aws-sdk-translate'

client = Aws::Translate::Client.new
resp = client.translate_text({
  text: "これは日本語のテキストです！",
  source_language_code: "ja",
  target_language_code: "en",
})

pp resp