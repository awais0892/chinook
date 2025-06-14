<?php
require_once 'config.php';

try {
    $conn = getDBConnection();
    
    $query = "SELECT a.AlbumId as id, a.Title as title, a.Price as price, 
                     ar.Name as artist_name, ar.ArtistId as artist_id
              FROM Album a
              JOIN Artist ar ON a.ArtistId = ar.ArtistId
              ORDER BY a.Title";
              
    $stmt = $conn->prepare($query);
    $stmt->execute();
    
    $albums = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    sendJSONResponse($albums);
} catch(PDOException $e) {
    sendJSONResponse(['error' => $e->getMessage()], 500);
}
?> 