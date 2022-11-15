/*list users*/
SELECT user FROM mysql.user;

/*change password*/
ALTER USER ‘nombreUsuario’@’localhost’ IDENTIFIED BY ‘NuevaContraseña’;
