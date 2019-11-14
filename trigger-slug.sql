CREATE TRIGGER `slugify` BEFORE INSERT ON `nombres` FOR EACH ROW
BEGIN
	DECLARE
		new_slug VARCHAR ( 255 );
	DECLARE
		slug_counter INT;
	
	SET slug_counter = 1;
	
	SET new_slug = new.title;
	
	SET new_slug = LOWER( TRIM( new_slug ) );
	
	SET new_slug = REPLACE ( new_slug, ':', '' );
	
	SET new_slug = REPLACE ( new_slug, ')', '' );
	
	SET new_slug = REPLACE ( new_slug, '(', '' );
	
	SET new_slug = REPLACE ( new_slug, ',', '' );
	
	SET new_slug = REPLACE ( new_slug, '.', '' );
	
	SET new_slug = REPLACE ( new_slug, "?", '' );
	
	SET new_slug = REPLACE ( new_slug, ';', '' );
	
	SET new_slug = REPLACE ( new_slug, '&', '' );
	
	SET new_slug = REPLACE ( new_slug, '!', '' );
	
	SET new_slug = REPLACE ( new_slug, '.', '' );
	
	SET new_slug = REPLACE ( new_slug, '€', '' );
	
	SET new_slug = REPLACE ( new_slug, 'euro;', '' );
	
	SET new_slug = REPLACE ( new_slug, ' ', '-' );
	
	SET new_slug = REPLACE ( new_slug, '--', '-' );
	
	SET new_slug = REPLACE ( new_slug, '--', '-' );
	
	SET new_slug = REPLACE ( new_slug, '--', '-' );
	
	SET new.slug = new_slug;
	WHILE
			EXISTS ( SELECT TRUE FROM test WHERE slug = new.slug ) DO
			
			SET new.slug = concat( new_slug, '-', slug_counter );
		
		SET slug_counter = slug_counter + 1;
		
	END WHILE;
	
END;
