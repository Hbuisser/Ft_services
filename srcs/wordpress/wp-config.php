<?php
/**
 * SOURCE: 
 * https://github.com/WordPress/WordPress/blob/master/wp-config-sample.php
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier contient les réglages de configuration suivants : réglages MySQL,
 * préfixe de table, clés secrètes, langue utilisée, et ABSPATH.
 * Vous pouvez en savoir plus à leur sujet en allant sur
 * {@link http://codex.wordpress.org/fr:Modifier_wp-config.php Modifier
 * wp-config.php}. C'est votre hébergeur qui doit vous donner vos
 * codes MySQL.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d'installation. Vous n'avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en "wp-config.php" et remplir les
 * valeurs.
 *
 * @package WordPress
 */
// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
 define( 'DB_NAME', 'wordpress' );
/** Utilisateur de la base de données MySQL. */
define( 'DB_USER', 'admin' );
/** Mot de passe de la base de données MySQL. */
define( 'DB_PASSWORD', 'admin' );
/** Adresse de l'hébergement MySQL. */
define( 'DB_HOST', 'localhost' );
/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define( 'DB_CHARSET', 'utf8mb4' );
/** Type de collation de la base de données.
 * N'y touchez que si vous savez ce que vous faites.
 */
define('DB_COLLATE', '');
/**#@+
* Clés uniques d'authentification et salage.
*
* Remplacez les valeurs par défaut par des phrases uniques !
* Vous pouvez générer des phrases aléatoires en utilisant
* {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clefs secrètes de WordPress.org}.
* Vous pouvez modifier ces phrases à n'importe quel moment, afin d'invalider tous les cookies existants.
* Cela forcera également tous les utilisateurs à se reconnecter.
*
* @since 2.6.0
 */
define('AUTH_KEY',         '!Y$FJm;L9&!um-yZcgCU-#RH[;@_t]-26f@f(EBX.y[L~?eSJRDRgA*8JbYCMo2M');
define('SECURE_AUTH_KEY',  'g7YU?IcPP$CmXhI=$@p*je)WGmuA*`%+/*Y/5MdiONtK/8COJo^5s|e_i?(aF-=n');
define('LOGGED_IN_KEY',    '|1BG2H3iy}S(%) #`O)VZ6hH5wjT;|93+v$H2{wl-z{c2=Y+E`4Bf!w.;uly0gZV');
define('NONCE_KEY',        '4>tPBPW=]}N}+9}}(_8iHgcaF8On[&eGMM=_A<aiy(z0ssG,s9S+pWa9yW,drA@*');
define('AUTH_SALT',        '&j_jyX/Q5ehP?}f)6(e}emT[!YHv#(>>5~c1p#e>[Hd/u/4iRrv[D.W-Q<65WWdl');
define('SECURE_AUTH_SALT', 'I{FxE$mCN$9Ycj-x/+:2}[Hl?<PTW,7-ypUP_P2(,BZiTWO?5XQtgj2]4rwnGV;+');
define('LOGGED_IN_SALT',   'M-YgDIq{V$Tj.Dx38vca6DYAGV}t4!rA<GIK+s# evC,@su/v5(?u}&zcG|c[4e}');
define('NONCE_SALT',       '].j4+>HG|o%ZNaZ *?+N]d)W@{}h|gEt-DDf_#)Ef_vWP32]Jz(7UXVD5&(}LK+Y');
/**#@-*/
/**
* Préfixe de base de données pour les tables de WordPress.
*
* Vous pouvez installer plusieurs WordPress sur une seule base de données
* si vous leur donnez chacune un préfixe unique.
* N'utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
*/
$table_prefix = 'wp_';
/**
* Pour les développeurs : le mode déboguage de WordPress.
*
* En passant la valeur suivante à "true", vous activez l'affichage des
* notifications d'erreurs pendant vos essais.
* Il est fortemment recommandé que les développeurs d'extensions et
* de thèmes se servent de WP_DEBUG dans leur environnement de
* développement.
*
* Pour plus d'information sur les autres constantes qui peuvent être utilisées
* pour le déboguage, rendez-vous sur le Codex.
*
* @link https://codex.wordpress.org/Debugging_in_WordPress
*/
define('WP_DEBUG', false);
/* C'est tout, ne touchez pas à ce qui suit ! Bonne publication. */
/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
define('ABSPATH', dirname(__FILE__) . '/');
/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');