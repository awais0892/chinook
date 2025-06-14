<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    try {
        // Get album ID from query string
        $albumId = isset($_GET['id']) ? validateInput($_GET['id']) : null;
        
        if (empty($albumId)) {
            throw new Exception('Album ID is required');
        }
        
        $conn = getDBConnection();
        
        $query = "SELECT a.AlbumId as id, a.Title as title, a.Price as price,
                        ar.ArtistId as artist_id, ar.Name as artist_name
                 FROM Album a
                 JOIN Artist ar ON a.ArtistId = ar.ArtistId
                 WHERE a.AlbumId = :albumId";
        
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':albumId', $albumId);
        $stmt->execute();
        
        $album = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$album) {
            throw new Exception('Album not found');
        }
        
        sendJSONResponse($album);
    } catch(Exception $e) {
        sendJSONResponse(['error' => $e->getMessage()], 400);
    }
} else {
    sendJSONResponse(['error' => 'Invalid request method'], 405);
}
?> 