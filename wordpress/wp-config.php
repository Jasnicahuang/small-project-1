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
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'dbwordpress' );

/** MySQL database username */
define( 'DB_USER', 'jasnica' );

/** MySQL database password */
define( 'DB_PASSWORD', '12345' );

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
define( 'AUTH_KEY',         '>LyZ<&@3/}(e|v/=s::+,Sbn-9m9L+im^sFMu5(g9ljOoaf=ff4=D#wGw0FQe}9(' );
define( 'SECURE_AUTH_KEY',  ' ESM6z05*Tx<U8gx.nD!X#DP)1>I*ZS{2eNX0q3D.sn$|hr,E|d)lseI`(]=&D)(' );
define( 'LOGGED_IN_KEY',    'xEF>XVa)neprkg1%a&fhJ5f7)do.-})j|%K j;_SkQZ/78?F0sh2`Y3Rzt<&W>uS' );
define( 'NONCE_KEY',        '*$6lA5-ja#tE(&9:83:F-l=2w>P)RNF}L&GLtXKJM,hzrto(&P2dAq[Z`Y@KpiBm' );
define( 'AUTH_SALT',        'S[H&5g-WgC?vu+=ybCPJg#xSWIRP<PLR[,yu[!|$t*^yWr#@`^x`[dq4V#1p2v8e' );
define( 'SECURE_AUTH_SALT', '<A#0W{Vv{EW%ov$tUH2I,?yY]m}%R[(mG#P]<?h8Y%4s7&4YEee_)(p9wtir!`q7' );
define( 'LOGGED_IN_SALT',   'lT&!_a*te<pR?|X=W:xE:B$0TKD>@Q<Sp!7Hr5]Dv>N2--iv](:;%:;U`GQEg`7|' );
define( 'NONCE_SALT',       'T5T<gOl`DA`SG-y2*cB]1b`x#0A7h9FgWfwZKur:M&|_IHs%p~v*iYnxh.rROUE{' );

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
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

