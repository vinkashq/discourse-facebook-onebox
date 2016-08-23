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
        oembed_data = '<aside class="quote facebook">' + '<div style="cursor: pointer;" class="title">
<div class="quote-controls"><i class="fa fa-chevron-down" title="expand/collapse"></i></div>
<a href="' + url + '"><i class="fa fa-facebook-square"></i></a></div>' + oembed_data + '</aside>'
      end

      def placeholder_html
        oembed_data = get_oembed_data[:html]
      end

      private

      def video?
        url =~ /\/video.php\?|\/videos\//
      end

      def get_oembed_data
        if video?
          Onebox::Helpers.symbolize_keys(::MultiJson.load(Onebox::Helpers.fetch_response("https://facebook.com/plugins/video/oembed.json?url=#{url}&maxwidth=661&omitscript=true").body))
        else
          Onebox::Helpers.symbolize_keys(::MultiJson.load(Onebox::Helpers.fetch_response("https://facebook.com/plugins/post/oembed.json?url=#{url}&maxwidth=661&omitscript=true").body))
        end
      end
    end
  end
end
