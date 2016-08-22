(function ($) {
  'use strict';

  if ($('#fb-root').length == 0 )
  $('body').prepend('<div id="fb-root"></div>');
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) FB.XFBML.parse();
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.3";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  var qXFBML;

  $.fn.embedFB = function () {
    if (typeof(FB) != 'undefined') {
      FB.XFBML.parse(this[0]);
    }
  };

})(jQuery);
