<?php
require_once 'config.php';

try {
    $query = "SELECT ArtistId as id, Name as name FROM Artist ORDER BY Name";
    
    $stmt = $conn->prepare($query);
    $stmt->execute();
    
    $artists = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    header('Content-Type: application/json');
    echo json_encode($artists);
} catch(PDOException $e) {
    header('Content-Type: application/json');
    http_response_code(500);
    echo json_encode(['error' => 'Error loading artists']);
}
?> 