//borrar post viejos en wordpress
UPDATE `wp_posts` SET `post_status` = REPLACE(`post_status`,'publish','trash')WHERE `post_date` < '2016-10-12 00:00:00' AND `post_type` = 'post' AND `post_status` = 'publish' 

// traer los post de una determinada categoria wordpress
SELECT * FROM wp_posts
    LEFT JOIN wp_term_relationships ON
    wp_posts.ID = wp_term_relationships.object_id
    LEFT JOIN wp_term_taxonomy ON
    wp_term_relationships.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id
    WHERE wp_posts.post_status = "publish"
    AND wp_term_taxonomy.taxonomy = "category"
    AND wp_term_taxonomy.term_id = 11
    ORDER BY post_date DESC

//cambiar urls
UPDATE wp_options SET option_value = REPLACE ( option_value, 'dominioA.com', 'dominioB.com' );
UPDATE wp_posts SET guid = REPLACE ( guid, 'dominioA.com', 'dominioB.com' );
UPDATE wp_posts SET post_content = REPLACE ( post_content, 'dominioA.com', 'dominioB.com' );
UPDATE wp_postmeta SET meta_value = REPLACE ( meta_value, 'dominioA.com', 'dominioB.com' );
