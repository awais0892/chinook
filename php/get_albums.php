<?php
require_once 'config.php';

try {
    $query = "SELECT a.AlbumId as id, a.Title as title, a.Price as price, 
                     ar.Name as artist_name, ar.ArtistId as artist_id
              FROM Album a
              JOIN Artist ar ON a.ArtistId = ar.ArtistId
              ORDER BY a.Title";
              
    $stmt = $conn->prepare($query);
    $stmt->execute();
    
    $albums = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    header('Content-Type: application/json');
    echo json_encode($albums);
} catch(PDOException $e) {
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?> 