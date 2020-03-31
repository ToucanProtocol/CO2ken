<?php 

function asset_url( $asset ) {
	return get_template_directory() . '/assets/' . $asset;
}

function asset_uri( $asset ) {
	return get_template_directory_uri() . '/assets/' . $asset;
}