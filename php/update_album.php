<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Get album ID from query string
        $albumId = isset($_GET['id']) ? validateInput($_GET['id']) : null;
        
        // Validate input
        $title = validateInput($_POST['title']);
        $artistId = validateInput($_POST['artist']);
        $price = validateInput($_POST['price']);
        
        if (empty($albumId)) {
            throw new Exception('Album ID is required');
        }
        
        if (empty($title) || empty($artistId) || empty($price)) {
            throw new Exception('All fields are required');
        }
        
        if (!is_numeric($price) || $price < 0) {
            throw new Exception('Price must be a positive number');
        }
        
        $conn = getDBConnection();
        
        // First check if album exists
        $checkQuery = "SELECT AlbumId FROM Album WHERE AlbumId = :albumId";
        $checkStmt = $conn->prepare($checkQuery);
        $checkStmt->bindParam(':albumId', $albumId);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() === 0) {
            throw new Exception('Album not found');
        }
        
        // Update the album
        $query = "UPDATE Album 
                 SET Title = :title, 
                     ArtistId = :artistId, 
                     Price = :price 
                 WHERE AlbumId = :albumId";
        
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':albumId', $albumId);
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':artistId', $artistId);
        $stmt->bindParam(':price', $price);
        
        $stmt->execute();
        
        sendJSONResponse(['message' => 'Album updated successfully']);
    } catch(Exception $e) {
        sendJSONResponse(['error' => $e->getMessage()], 400);
    }
} else {
    sendJSONResponse(['error' => 'Invalid request method'], 405);
}
?> 