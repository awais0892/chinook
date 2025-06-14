<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chinook Album Management</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Add SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">
    <style>
        .background-pattern {
            background-image: url('https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?auto=format&fit=crop&q=80');
        }
    </style>
</head>
<body>
    <div class="background-pattern"></div>
    <div class="container">
        <header class="header">
            <div class="header-content">
                <div class="logo-section">
                    <div class="logo-icon">
                        <i class="fas fa-record-vinyl"></i>
                    </div>
                    <div class="logo-text">
                        <h1>Chinook</h1>
                        <p>Album Management System</p>
                    </div>
                </div>
                <div class="header-decoration">
                    <div class="music-notes">
                        <i class="fas fa-music"></i>
                        <i class="fas fa-music"></i>
                        <i class="fas fa-music"></i>
                    </div>
                </div>
            </div>
        </header>
        
        <main class="main-content">
            <div class="control-panel">
                <div class="control-section">
                    <button onclick="showAddAlbumForm()" class="btn-primary btn-add">
                        <i class="fas fa-plus-circle"></i>
                        <span>Add New Album</span>
                    </button>
                </div>
                
                <div class="search-filters">
                    <div class="search-box">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" id="searchInput" placeholder="Search albums by title or artist...">
                    </div>
                    
                    <div class="filter-controls">
                        <div class="filter-group">
                            <label>Sort By</label>
                            <select id="sortSelect" class="select-elegant">
                                <option value="title">Title A-Z</option>
                                <option value="artist">Artist A-Z</option>
                                <option value="price_asc">Price: Low to High</option>
                                <option value="price_desc">Price: High to Low</option>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label>Artist</label>
                            <select id="filterArtist" class="select-elegant">
                                <option value="">All Artists</option>
                                <!-- Artists will be loaded dynamically -->
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label>Price Range</label>
                            <select id="filterPrice" class="select-elegant">
                                <option value="">All Prices</option>
                                <option value="0-10">$0 - $10</option>
                                <option value="10-20">$10 - $20</option>
                                <option value="20-30">$20 - $30</option>
                                <option value="30+">$30+</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="albums-section">
                <div class="section-header">
                    <h2><i class="fas fa-compact-disc"></i> Music Collection</h2>
                    <div class="view-toggle">
                        <button class="view-btn active" data-view="grid">
                            <i class="fas fa-th-large"></i>
                        </button>
                        <button class="view-btn" data-view="list">
                            <i class="fas fa-list"></i>
                        </button>
                    </div>
                </div>
                
                <div id="albumList" class="album-grid">
                    <!-- Albums will be loaded here dynamically -->
                </div>
            </div>

            <!-- Add/Edit Album Form Modal -->
            <div id="addAlbumForm" class="modal">
                <div class="modal-backdrop"></div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h2><i class="fas fa-plus-circle"></i> Add New Album</h2>
                        <button type="button" onclick="hideAddAlbumForm()" class="close-btn">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    
                    <form id="albumForm" action="php/add_album.php" method="POST" class="elegant-form">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="title">
                                    <i class="fas fa-album"></i>
                                    Album Title
                                </label>
                                <input type="text" id="title" name="title" required 
                                       placeholder="Enter album title">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="artist">
                                    <i class="fas fa-user-music"></i>
                                    Artist
                                </label>
                                <select id="artist" name="artist" required class="select-elegant">
                                    <option value="">Select an artist</option>
                                    <!-- Artists will be loaded dynamically -->
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="price">
                                    <i class="fas fa-dollar-sign"></i>
                                    Price
                                </label>
                                <input type="number" id="price" name="price" step="0.01" min="0" required 
                                       placeholder="Enter price">
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" onclick="hideAddAlbumForm()" class="btn-secondary">
                                <i class="fas fa-times"></i>
                                Cancel
                            </button>
                            <button type="submit" class="btn-primary">
                                <i class="fas fa-save"></i>
                                Save Album
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>

    <!-- Add SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/script.js"></script>
</body>
</html>