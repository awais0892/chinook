<?php
require_once 'config.php';

try {
    $conn = getDBConnection();
    
    $query = "SELECT ArtistId as id, Name as name FROM Artist ORDER BY Name";
    
    $stmt = $conn->prepare($query);
    $stmt->execute();
    
    $artists = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    sendJSONResponse($artists);
} catch(PDOException $e) {
    sendJSONResponse(['error' => $e->getMessage()], 500);
}
?> 