<?php
if (session_status() != PHP_SESSION_ACTIVE) {
	session_start();
}

// Load our ACF configuration
require_once get_template_directory() . '/inc/acf/config.php';

// Load our helper functions
require_once get_template_directory() . '/inc/helpers.php';

class Co2ken {

	private $resource_ver = '1.3.8';

	public function __construct() {
		// Enqueue some magic
		if( ! is_admin() ) {
			add_action( 'wp_enqueue_scripts', array( $this, 'co2ken_enqueue_assets' ) );
		}

		add_action( 'admin_enqueue_scripts', array( $this, 'co2ken_enqueue_admin_assets' ) );

		// Remove the generator reference
		add_filter( 'the_generator', array( $this, 'co2ken_remove_version' ) );

		// Disable the xmlrpc
		add_filter( 'xmlrpc_enabled', '__return_false' );

		// Theme Setup.
		add_action( 'after_setup_theme', array( $this, 'co2ken_global_setup' ) );

		// Add body class
		add_filter( 'body_class', array( $this, 'add_slug_body_class' ) );

		// Set up fallback meta description if none is set
    add_filter( 'wpseo_metadesc', [ $this, 'add_custom_meta_des' ], 10, 1 );
	}

	// Theme Setup.
	public function co2ken_global_setup() {

		// Enable support for Post Thumbnails, and declare two sizes.
		add_theme_support( 'post-thumbnails' );
		set_post_thumbnail_size( 150, 150, true );

		// Set up custom image sizes
		// add_image_size( 'provider', 100 );

		// Add RSS feed links to <head> for posts and comments.
		add_theme_support( 'automatic-feed-links' );

		// This theme uses wp_nav_menu().
		register_nav_menus( array(

      // Main navigation
      'main_nav'     => __( 'Main Menu', 'co2ken' ),

			// Footer navigation
			'footer_nav_1' => __( 'Footer Nav 1', 'co2ken' ),
			'footer_nav_2' => __( 'Footer Nav 2', 'co2ken' ),
		) );

		// Switch default core markup for search form, comment form, and comments to output valid HTML5.
		add_theme_support( 'html5', array(
			'search-form',
			'comment-form',
			'comment-list',
			'gallery',
			'caption'
		) );

	}

	// Unregister all widgets we dont need
	public function unregister_default_widgets() {
		unregister_widget( 'WP_Widget_Calendar' );
		unregister_widget( 'WP_Widget_Recent_Comments' );
		unregister_widget( 'WP_Widget_Search' );
		unregister_widget( 'WP_Widget_Archives' );
		unregister_widget( 'WP_Widget_Meta' );
		unregister_widget( 'WP_Widget_Categories' );
		unregister_widget( 'WP_Widget_Tag_Cloud' );
		unregister_widget( 'WP_Widget_RSS' );
		unregister_widget( 'WP_Widget_Recent_Posts' );
		unregister_widget( 'WP_Widget_Pages' );
	}

	// Page Slug Body Class
	public function add_slug_body_class( $classes ) {
		global $post;

		if ( isset( $post ) ) {
			$classes[] = $post->post_type . '-' . $post->post_name;
    }
    
    if ( WP_DEBUG ) {
      $classes[] = 'wp_debug';
    }

		return $classes;
	}

	// load css into the website's front-end
	public function co2ken_enqueue_assets() {

		// Add CSS
    wp_enqueue_style( 'co2ken-style', asset_uri( 'css/main.css' ), false, time() );

		// Add JS
    wp_enqueue_script( 'co2ken-app', asset_uri( 'js/bundles/app.bundle.js' ), array( 'jquery' ), $this->resource_ver, true );

		// Reset our jQuery source
		wp_deregister_script( 'jquery' );
		wp_enqueue_script( 'jquery', '//code.jquery.com/jquery-3.1.1.min.js', false, $this->resource_ver, false );

    // Enqueue FontAwesome
    wp_enqueue_script( 'co2ken-fontawesome-js', asset_uri( 'js/libraries/fontawesome.min.js' ), array( 'jquery' ), $this->resource_ver, true );
		wp_enqueue_style( 'co2ken-fontawesome-css', asset_uri('css/fontawesome/svg-with-js.min.css'), false, $this->resource_ver );

		// Remove WP Embed
		wp_deregister_script( 'wp-embed' );

		// Pass ajax information to our script
		wp_localize_script( 'co2ken-app', 'co2ken', array(
			'ajaxurl' 		=> admin_url( 'admin-ajax.php' ),
			'whoisawesome' 	=> 'Twade', // A little treat for the easter bunny
		));
	}

	public function co2ken_enqueue_admin_assets() {
		// Add JS
		wp_enqueue_script( 'co2ken-admin-core', asset_uri( 'js/admin/admin.js' ), array( 'jquery' ), $this->resource_ver, true );
	}

	// load css into the login page
	public function co2ken_enqueue_login_style() {
	    wp_enqueue_style( 'co2ken-login', get_template_directory_uri() . '/css/login.css' ); 
	}

	public function co2ken_remove_version() {
		return '';
	}

	public function fix_broken_acf_update( $field_key, $field_name, $post_id ) {
		// get field groups
		$field_groups = acf_get_field_groups();
			
		if( !empty($field_groups) ) {
			
			foreach( $field_groups as $i => $field_group ) {
				// Check the visibility against the ACF file
				$match = acf_get_field_group_visibility( $field_group, array( 'post_id' => $post_id ) );

				if( $match && array_key_exists('local', $field_group) && $field_group['local'] == 'json' ) {
					// Now load the ACF file
					$acf_file = json_decode( file_get_contents( get_template_directory() . '/inc/acf/' . $field_group['key'] . '.json' ) );

					// Loop through fields until we match the field name
					foreach( $acf_file->fields as $field ) {
						if( $field->name == $field_name ) {
							$field_key = $field->key;

							break;
						}
					}
				}
			}
		}

		return $field_key;
	}
}

// Smile! Everyone is watching. - Jihn, 2016
new Co2ken;