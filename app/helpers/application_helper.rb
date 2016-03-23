module ApplicationHelper
  def full_title(page_title)
    base_title = 'Rubyboost'

    if page_title.empty?
      base_title
    else
      "#{base_title} #{page_title}"
    end
  end

  def build_facebook_response(token)
    facebook_connection = Faraday.new(url: 'https://graph.facebook.com/v2.5/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end

    response = facebook_connection.get do |connection|
      connection.url '/me', fields: 'id'
      connection.params[:client_id] = OmnyAuthConfig['facebook']['key']
      connection.params[:client_secret] = OmnyAuthConfig['facebook']['secret']
      connection.params[:access_token] = token
    end
  end
end
