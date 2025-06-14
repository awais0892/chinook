<?php
require_once 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        // Validate input
        $title = validateInput($_POST['title']);
        $artistId = validateInput($_POST['artist']);
        $price = validateInput($_POST['price']);
        
        if (empty($title) || empty($artistId) || empty($price)) {
            throw new Exception('All fields are required');
        }
        
        if (!is_numeric($price) || $price < 0) {
            throw new Exception('Price must be a positive number');
        }
        
        $conn = getDBConnection();
        
        $query = "INSERT INTO Album (Title, ArtistId, Price) VALUES (:title, :artistId, :price)";
        
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':artistId', $artistId);
        $stmt->bindParam(':price', $price);
        
        $stmt->execute();
        
        sendJSONResponse(['message' => 'Album added successfully']);
    } catch(Exception $e) {
        sendJSONResponse(['error' => $e->getMessage()], 400);
    }
} else {
    sendJSONResponse(['error' => 'Invalid request method'], 405);
}
?> 