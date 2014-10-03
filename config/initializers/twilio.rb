path = File.join(Rails.root, "config/twilio.yml")
TWILIO_CONFIG = YAML.load(File.read(path))[Rails.env] || {'sid' => 'AC387bfdbdaf7b4cc51158ff689d26eeeb', 'from' => '508 413-3256', 'token' => '8db2af4157fa1ff7cddea887be71f5c4'}
