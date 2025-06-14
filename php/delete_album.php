<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    try {
        // Get album ID from query string
        $albumId = isset($_GET['id']) ? validateInput($_GET['id']) : null;
        
        if (empty($albumId)) {
            throw new Exception('Album ID is required');
        }
        
        $conn = getDBConnection();
        
        // Delete the album directly
        $query = "DELETE FROM Album WHERE AlbumId = :albumId";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':albumId', $albumId);
        $stmt->execute();
        
        if ($stmt->rowCount() === 0) {
            throw new Exception('Album not found');
        }
        
        sendJSONResponse(['message' => 'Album deleted successfully']);
    } catch(Exception $e) {
        sendJSONResponse(['error' => $e->getMessage()], 400);
    }
} else {
    sendJSONResponse(['error' => 'Invalid request method'], 405);
}
?> 