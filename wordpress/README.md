# WordPress

WordPress template for CO2ken using TypeScript and webpack.

## Setup

1. Add the MySQL database (./db/co2ken.sql) to your server.

2. Upload the WordPress folder to your server.

3. Update the `wp-config.php` file with the database credentials.

## Development

1. Run `npm install`.

2. Run `npm start` to begin the webpack listening service for converting TypeScript into web-friendly JavaScript.

3. Use a program like prepros to compile SCSS to CSS.
