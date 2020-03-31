(() => {
  let $logo = jQuery('.header__logo > img'),
    $topLogo = jQuery('.top-bar__logo'),
    logoHeight = $logo.outerHeight(),
    logoOffset = $logo.offset().top;

  let threshold = logoHeight + logoOffset;
  $(window).on('scroll', () => {
    let scrollFromTop = $(document).scrollTop();
    let index = scrollFromTop / threshold;
    if (index >= 1) {
      $topLogo.css('opacity', 1);
    } else {
      $topLogo.css('opacity', index);
    }
  });

  // smooth scrolling
  $('a[href*="#"]')
    // Remove links that don't actually link to anything
    .not('[href="#"]')
    .not('[href="#0"]')
    .click(function (event) {
      // On-page links
      if (
        location.pathname.replace(/^\//, '') === (<any>this).pathname.replace(/^\//, '')
        &&
        location.hostname === (<any>this).hostname
      ) {
        // Figure out element to scroll to
        let target = $((<any>this).hash);
        target = target.length ? target : $('[name=' + (<any>this).hash.slice(1) + ']');
        // Does a scroll target exist?
        if (target.length) {
          // Only prevent default if animation is actually gonna happen
          event.preventDefault();
          console.log(target);
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 500, function () {
            // Callback after animation
          });
        }
      }
    });
})();