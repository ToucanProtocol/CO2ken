<head>
  <meta http-equiv="content-type"
    content="<?php bloginfo( 'html_type' ); ?>; charset=<?php bloginfo( 'charset' ); ?>" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
  <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
  <link rel="manifest" href="/site.webmanifest">
  <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
  <meta name="msapplication-TileColor" content="#da532c">
  <meta name="theme-color" content="#ffffff">
  <link rel="icon" href="<?php echo asset_uri('images/favicon.png'); ?>" />
  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;700&display=swap" rel="stylesheet">
  <title><?php wp_title(); ?></title>
  <script src="https://kit.fontawesome.com/a2c20fdc25.js" crossorigin="anonymous"></script>

  <?php wp_head(); ?>
</head>
<div id="top"></div>
<div class="top-bar">
  <div class="container">
    <div class="top-bar__logo">
      <a href="#top"><img src="<?php echo asset_uri('images/brand/logo.png'); ?>" /></a>
    </div>
    <?php wp_nav_menu( ['menu' => 'main_nav'] ); ?>
  </div>
</div>

<div class="header">
  <div class="container">
    <div class="header__logo">
      <img src="<?php echo asset_uri('images/brand/logo-full.png'); ?>" />
    </div>
  </div>
</div>