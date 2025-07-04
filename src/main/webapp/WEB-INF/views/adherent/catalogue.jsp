<!DOCTYPE html>
<html>
<head>
    <title>Catalogue - Gestion de Bibliothèque</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }
        
        .header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        .logout-btn {
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .nav-menu {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .nav-item {
            background: white;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        
        .nav-item:hover, .nav-item.active {
            background: #4CAF50;
            color: white;
            border-color: #4CAF50;
        }
        
        .page-title {
            color: #4CAF50;
            margin-bottom: 2rem;
            font-size: 2rem;
        }
        
        .search-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .search-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .search-input {
            flex: 1;
            padding: 1rem;
            border: 2px solid #eee;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .search-input:focus {
            outline: none;
            border-color: #4CAF50;
        }
        
        .search-btn {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        }
        
        .filters {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
            flex-wrap: wrap;
        }
        
        .filter-select {
            padding: 0.5rem;
            border: 1px solid #eee;
            border-radius: 5px;
            background: white;
        }
        
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .book-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s;
        }
        
        .book-card:hover {
            transform: translateY(-5px);
        }
        
        .book-cover {
            height: 200px;
            background: linear-gradient(135deg, #4CAF50, #45a049);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
        }
        
        .book-info {
            padding: 1.5rem;
        }
        
        .book-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .book-author {
            color: #666;
            margin-bottom: 1rem;
        }
        
        .book-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .book-genre {
            background: #e8f5e8;
            color: #2e7d32;
            padding: 0.25rem 0.5rem;
            border-radius: 15px;
            font-size: 0.8rem;
        }
        
        .book-availability {
            font-weight: bold;
        }
        
        .available {
            color: #4CAF50;
        }
        
        .unavailable {
            color: #f44336;
        }
        
        .book-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn {
            flex: 1;
            padding: 0.75rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            text-align: center;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #4CAF50;
            color: white;
        }
        
        .btn-primary:hover {
            background: #45a049;
        }
        
        .btn-secondary {
            background: #666;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #555;
        }
        
        .btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .empty-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        .empty-title {
            font-size: 1.5rem;
            color: #666;
            margin-bottom: 1rem;
        }
        
        .empty-text {
            color: #999;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>🏛️ Bibliothèque - Espace Adhérent</h1>
            <div class="user-info">
                <div class="user-avatar">
                    ${adherent.prenom.charAt(0)}${adherent.nom.charAt(0)}
                </div>
                <div>
                    <div>${adherent.prenom} ${adherent.nom}</div>
                    <small>${adherent.typeUtilisateur.nomType}</small>
                </div>
                <a href="/adherent/logout" class="logout-btn">Déconnexion</a>
            </div>
        </div>
    </div>
    
    <div class="container">
        <div class="nav-menu">
            <a href="/adherent/dashboard" class="nav-item">Dashboard</a>
            <a href="/adherent/emprunts" class="nav-item">Mes Emprunts</a>
            <a href="/adherent/reservations" class="nav-item">Mes Réservations</a>
            <a href="/adherent/catalogue" class="nav-item active">Catalogue</a>
            <a href="/adherent/profile" class="nav-item">Mon Profil</a>
        </div>
        
        <h1 class="page-title">Catalogue des Livres</h1>
        
        <div class="search-section">
            <form class="search-form">
                <input type="text" class="search-input" placeholder="Rechercher un livre, un auteur..." />
                <button type="submit" class="search-btn">🔍 Rechercher</button>
            </form>
            <div class="filters">
                <select class="filter-select">
                    <option>Tous les genres</option>
                    <option>Roman</option>
                    <option>Science-fiction</option>
                    <option>Fantasy</option>
                    <option>Policier</option>
                </select>
                <select class="filter-select">
                    <option>Tous les statuts</option>
                    <option>Disponible</option>
                    <option>Emprunté</option>
                </select>
                <select class="filter-select">
                    <option>Trier par</option>
                    <option>Titre</option>
                    <option>Auteur</option>
                    <option>Date de publication</option>
                </select>
            </div>
        </div>
        
        <div class="books-grid">
            <div class="book-card">
                <div class="book-cover">📚</div>
                <div class="book-info">
                    <div class="book-title">Le Petit Prince</div>
                    <div class="book-author">Antoine de Saint-Exupéry</div>
                    <div class="book-details">
                        <span class="book-genre">Roman</span>
                        <span class="book-availability available">Disponible</span>
                    </div>
                    <div class="book-actions">
                        <button class="btn btn-primary">Réserver</button>
                        <button class="btn btn-secondary">Détails</button>
                    </div>
                </div>
            </div>
            
            <div class="book-card">
                <div class="book-cover">📖</div>
                <div class="book-info">
                    <div class="book-title">1984</div>
                    <div class="book-author">George Orwell</div>
                    <div class="book-details">
                        <span class="book-genre">Science-fiction</span>
                        <span class="book-availability unavailable">Emprunté</span>
                    </div>
                    <div class="book-actions">
                        <button class="btn btn-primary" disabled>Réserver</button>
                        <button class="btn btn-secondary">Détails</button>
                    </div>
                </div>
            </div>
            
            <div class="book-card">
                <div class="book-cover">🔮</div>
                <div class="book-info">
                    <div class="book-title">Harry Potter à l'école des sorciers</div>
                    <div class="book-author">J.K. Rowling</div>
                    <div class="book-details">
                        <span class="book-genre">Fantasy</span>
                        <span class="book-availability available">Disponible</span>
                    </div>
                    <div class="book-actions">
                        <button class="btn btn-primary">Réserver</button>
                        <button class="btn btn-secondary">Détails</button>
                    </div>
                </div>
            </div>
            
            <div class="book-card">
                <div class="book-cover">💍</div>
                <div class="book-info">
                    <div class="book-title">Le Seigneur des Anneaux</div>
                    <div class="book-author">J.R.R. Tolkien</div>
                    <div class="book-details">
                        <span class="book-genre">Fantasy</span>
                        <span class="book-availability available">Disponible</span>
                    </div>
                    <div class="book-actions">
                        <button class="btn btn-primary">Réserver</button>
                        <button class="btn btn-secondary">Détails</button>
                    </div>
                </div>
            </div>
            
            <div class="book-card">
                <div class="book-cover">🔍</div>
                <div class="book-info">
                    <div class="book-title">Sherlock Holmes</div>
                    <div class="book-author">Arthur Conan Doyle</div>
                    <div class="book-details">
                        <span class="book-genre">Policier</span>
                        <span class="book-availability available">Disponible</span>
                    </div>
                    <div class="book-actions">
                        <button class="btn btn-primary">Réserver</button>
                        <button class="btn btn-secondary">Détails</button>
                    </div>
                </div>
            </div>
            
            <div class="book-card">
                <div class="book-cover">🌍</div>
                <div class="book-info">
                    <div class="book-title">Le Monde de Narnia</div>
                    <div class="book-author">C.S. Lewis</div>
                    <div class="book-details">
                        <span class="book-genre">Fantasy</span>
                        <span class="book-availability unavailable">Emprunté</span>
                    </div>
                    <div class="book-actions">
                        <button class="btn btn-primary" disabled>Réserver</button>
                        <button class="btn btn-secondary">Détails</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 