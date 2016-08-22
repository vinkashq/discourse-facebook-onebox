# name: discourse-facebook-onebox
# about: Discourse Onebox to display Facebook elements
# version: 0.1
# authors: Vinoth Kannan (vinothkannans)
# url: https://github.com/vinkas0/discourse-facebook-onebox

# javascript
register_asset "javascripts/embedFB.js"

# Without this, there is an error when loading/precompiling:
# NoMethodError: undefined method `matches_regexp'
Onebox = Onebox

module Onebox
  module Engine
    class FacebookOnebox
      include Engine
      include StandardEmbed

      matches_regexp(/^https?:\/\/.*facebook\.com/)
      always_https

      def to_html
        oembed_data = get_oembed_data[:html]
        oembed_data = '<div class="embedFB">' + oembed_data + '</div>'
      end

      private

      def video?
        url =~ /\/video.php\?|\/videos\//
      end

      def get_oembed_data
        if video?
          Onebox::Helpers.symbolize_keys(::MultiJson.load(Onebox::Helpers.fetch_response("https://facebook.com/plugins/video/oembed.json?url=#{url}&maxwidth=690&omitscript=true").body))
        else
          Onebox::Helpers.symbolize_keys(::MultiJson.load(Onebox::Helpers.fetch_response("https://facebook.com/plugins/post/oembed.json?url=#{url}&maxwidth=690&omitscript=true").body))
        end
      end
    end
  end
end
