file = File.read("#{Rails.root}/config/omniauth_tokens.yml")
OmnyAuthConfig = YAML.load(ERB.new(file).result)[Rails.env]
