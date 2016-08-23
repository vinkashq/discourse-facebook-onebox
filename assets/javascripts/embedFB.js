(function ($) {
  'use strict';

  $(".fb-post").attr("fb-xfbml-state", "rendered");
  $(".fb-video").attr("fb-xfbml-state", "rendered");
  if ($('#fb-root').length == 0 )
  $('body').prepend('<div id="fb-root"></div>');
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) FB.XFBML.parse();
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  $('#main').on('click', '.quote.facebook .title', function () {
    parseXFBML(this[0]);
    return false;
  });

  $('#main').on('click', '.quote.facebook i.fa-chevron-down', function () {
    parseXFBML(this[0]);
    return false;
  });

  function parseXFBML(elem) {
    if (typeof(FB) != 'undefined') {
      FB.XFBML.parse(elem);
    }
  }

})(jQuery);
