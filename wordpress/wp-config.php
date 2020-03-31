<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'co2ken' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'root' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'zR>#(gA5w^RkV$ vZ-jQ2dX)<%Y#J=jmX)SA=mTI#eoU%ho)# WmyITRzMafQu68' );
define( 'SECURE_AUTH_KEY',  'wUQM*;>)ieJu5e|uaKi#!TmF?5`XD[ab}qzUp{gH}@9}n)!v:HHS4(.i0,cl;#a{' );
define( 'LOGGED_IN_KEY',    '~E^!o9Z#eYnW#~Yoorf#,.~k?qewCeW)b:!R* ~05GPH>1cC.Bq$1=TZ7oxT{.Pn' );
define( 'NONCE_KEY',        'BV|vW_/@r8v6,-tlvS[h_05w+B*Tl*.W%3>{}bRCGq_+,sEBq.$y$/k93NZPC$<7' );
define( 'AUTH_SALT',        'D!.)J4:B)Mh`N)b-G!C#qj[`)/<+0V0+@_wn;]<u+8wG`6@h?W8ej|Xx2E`g@~A,' );
define( 'SECURE_AUTH_SALT', '[j;*-NPg/bF%1iF[}2yB:HfEV;4?T6f:G,P[@@w8rhL$Uq-%Yj|CYi@THFnp9#^w' );
define( 'LOGGED_IN_SALT',   '+FoRwhK3on8?>`m,C,<@[%]gvlXCOygELUm7(x+s1hA:~DHKG`kO!<r2$#ODY3(0' );
define( 'NONCE_SALT',       'r(/C]t~*Z.o)=Bfu]ltZ=3eAK(*w]+fANbNeMG.Jb<S{ucv+|xKMK!VmLUm-RO4/' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG',        true );
define( 'WP_DEBUG_LOG',     false );
define( 'WP_DEBUG_DISPLAY', true );
define( 'SCRIPT_DEBUG',     false );
define( 'SAVEQUERIES',      true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
