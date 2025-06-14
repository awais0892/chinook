// Global variables
let albums = [];
let artists = [];

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    loadAlbums();
    loadArtists();
    setupEventListeners();
});

// Event Listeners
function setupEventListeners() {
    const searchInput = document.getElementById('searchInput');
    const sortSelect = document.getElementById('sortSelect');
    const filterArtist = document.getElementById('filterArtist');
    const filterPrice = document.getElementById('filterPrice');

    searchInput.addEventListener('input', filterAlbums);
    sortSelect.addEventListener('change', sortAlbums);
    filterArtist.addEventListener('change', filterAlbums);
    filterPrice.addEventListener('change', filterAlbums);

    // Form submission handler
    document.getElementById('albumForm').addEventListener('submit', handleFormSubmit);
}

// Load albums from the server
async function loadAlbums() {
    try {
        const response = await fetch('php/get_albums.php');
        if (!response.ok) throw new Error('Network response was not ok');
        albums = await response.json();
        displayAlbums(albums);
    } catch (error) {
        console.error('Error loading albums:', error);
        showNotification('Error loading albums. Please try again later.', 'error');
    }
}

// Load artists from the server
async function loadArtists() {
    try {
        const response = await fetch('php/get_artists.php');
        if (!response.ok) throw new Error('Network response was not ok');
        artists = await response.json();
        populateArtistSelects();
    } catch (error) {
        console.error('Error loading artists:', error);
        showNotification('Error loading artists. Please try again later.', 'error');
    }
}

// Populate artist select dropdowns
function populateArtistSelects() {
    const artistSelects = ['artist', 'filterArtist'];
    artistSelects.forEach(selectId => {
        const select = document.getElementById(selectId);
        select.innerHTML = selectId === 'filterArtist' 
            ? '<option value="">All Artists</option>'
            : '<option value="">Select an artist</option>';
        
        artists.forEach(artist => {
            const option = document.createElement('option');
            option.value = artist.id;
            option.textContent = artist.name;
            select.appendChild(option);
        });
    });
}

// Display albums in the grid
function displayAlbums(albumsToDisplay) {
    const albumList = document.getElementById('albumList');
    albumList.innerHTML = '';

    if (albumsToDisplay.length === 0) {
        albumList.innerHTML = `
            <div class="no-results">
                <i class="fas fa-search"></i>
                <p>No albums found matching your criteria</p>
            </div>
        `;
        return;
    }

    albumsToDisplay.forEach(album => {
        const albumCard = document.createElement('div');
        albumCard.className = 'album-card';
        albumCard.innerHTML = `
            <h3>${album.title}</h3>
            <p><i class="fas fa-user"></i> ${album.artist_name}</p>
            <p><i class="fas fa-tag"></i> $${parseFloat(album.price).toFixed(2)}</p>
            <div class="album-actions">
                <button onclick="editAlbum(${album.id})" class="btn-primary">
                    <i class="fas fa-edit"></i> Edit
                </button>
                <button onclick="deleteAlbum(${album.id})" class="btn-secondary">
                    <i class="fas fa-trash"></i> Delete
                </button>
            </div>
        `;
        albumList.appendChild(albumCard);
    });
}

// Filter albums based on search input and filters
function filterAlbums() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const selectedArtist = document.getElementById('filterArtist').value;
    const selectedPriceRange = document.getElementById('filterPrice').value;

    let filteredAlbums = albums.filter(album => {
        const matchesSearch = album.title.toLowerCase().includes(searchTerm) ||
                            album.artist_name.toLowerCase().includes(searchTerm);
        
        const matchesArtist = !selectedArtist || album.artist_id === selectedArtist;
        
        const matchesPrice = !selectedPriceRange || (() => {
            const price = parseFloat(album.price);
            switch(selectedPriceRange) {
                case '0-10': return price >= 0 && price <= 10;
                case '10-20': return price > 10 && price <= 20;
                case '20-30': return price > 20 && price <= 30;
                case '30+': return price > 30;
                default: return true;
            }
        })();

        return matchesSearch && matchesArtist && matchesPrice;
    });

    sortAlbums(filteredAlbums);
}

// Sort albums based on selected criteria
function sortAlbums(albumsToSort = null) {
    const sortBy = document.getElementById('sortSelect').value;
    const albumsToUse = albumsToSort || [...albums];
    
    const sortedAlbums = albumsToUse.sort((a, b) => {
        switch(sortBy) {
            case 'title':
                return a.title.localeCompare(b.title);
            case 'artist':
                return a.artist_name.localeCompare(b.artist_name);
            case 'price_asc':
                return parseFloat(a.price) - parseFloat(b.price);
            case 'price_desc':
                return parseFloat(b.price) - parseFloat(a.price);
            default:
                return 0;
        }
    });
    
    displayAlbums(sortedAlbums);
}

// Show add album form
function showAddAlbumForm() {
    document.getElementById('addAlbumForm').style.display = 'block';
    document.getElementById('albumForm').reset();
    document.getElementById('albumForm').action = 'php/add_album.php';
    document.querySelector('.modal-content h2').innerHTML = '<i class="fas fa-plus"></i> Add New Album';
}

// Hide add album form
function hideAddAlbumForm() {
    document.getElementById('addAlbumForm').style.display = 'none';
}

// Handle form submission
async function handleFormSubmit(event) {
    event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    const isEdit = form.action.includes('update_album.php');
    
    try {
        const response = await fetch(form.action, {
            method: 'POST',
            body: formData
        });
        
        const result = await response.json();
        
        if (response.ok) {
            await Swal.fire({
                title: isEdit ? 'Updated!' : 'Added!',
                text: isEdit ? 'Album has been updated.' : 'Album has been added.',
                icon: 'success',
                confirmButtonColor: '#2563eb'
            });
            
            hideAddAlbumForm();
            loadAlbums();
        } else {
            throw new Error(result.error || (isEdit ? 'Failed to update album' : 'Failed to add album'));
        }
    } catch (error) {
        console.error('Error saving album:', error);
        Swal.fire({
            title: 'Error!',
            text: error.message,
            icon: 'error',
            confirmButtonColor: '#dc2626'
        });
    }
}

// Edit album
async function editAlbum(albumId) {
    try {
        const response = await fetch(`php/get_album.php?id=${albumId}`);
        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(errorData.error || 'Failed to load album details');
        }
        
        const album = await response.json();
        
        // Update form action and title
        const form = document.getElementById('albumForm');
        form.action = `php/update_album.php?id=${albumId}`;
        document.querySelector('.modal-content h2').innerHTML = '<i class="fas fa-edit"></i> Edit Album';
        
        // Populate form with album data
        document.getElementById('title').value = album.title;
        document.getElementById('artist').value = album.artist_id;
        document.getElementById('price').value = parseFloat(album.price).toFixed(2);
        
        // Show form
        document.getElementById('addAlbumForm').style.display = 'block';
    } catch (error) {
        console.error('Error loading album details:', error);
        showNotification(error.message || 'Error loading album details. Please try again later.', 'error');
    }
}

// Delete album
async function deleteAlbum(albumId) {
    const album = albums.find(a => a.id === albumId);
    
    const result = await Swal.fire({
        title: 'Delete Album',
        html: `Are you sure you want to delete <strong>${album.title}</strong>?<br>This action cannot be undone.`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc2626',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, delete it',
        cancelButtonText: 'Cancel',
        reverseButtons: true,
        customClass: {
            confirmButton: 'btn btn-danger',
            cancelButton: 'btn btn-secondary'
        }
    });

    if (result.isConfirmed) {
        try {
            const response = await fetch(`php/delete_album.php?id=${albumId}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
            
            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || 'Failed to delete album');
            }
            
            const result = await response.json();
            
            await Swal.fire({
                title: 'Deleted!',
                text: result.message || 'Album has been deleted.',
                icon: 'success',
                confirmButtonColor: '#2563eb'
            });
            
            loadAlbums();
        } catch (error) {
            console.error('Error deleting album:', error);
            Swal.fire({
                title: 'Error!',
                text: error.message || 'Error deleting album. Please try again later.',
                icon: 'error',
                confirmButtonColor: '#dc2626'
            });
        }
    }
}

// Show notification
function showNotification(message, type = 'info') {
    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    Toast.fire({
        icon: type === 'success' ? 'success' : 'error',
        title: message
    });
} 