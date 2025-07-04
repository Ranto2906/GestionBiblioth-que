<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Utilisateur - Gestion de Bibliothèque</title>
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
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
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
        
        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .welcome-title {
            color: #2196F3;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2196F3;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .action-btn {
            background: linear-gradient(135deg, #2196F3, #1976D2);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            font-weight: bold;
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.4);
        }
        
        .action-btn.admin {
            background: linear-gradient(135deg, #FF5722, #E64A19);
        }
        
        .action-btn.admin:hover {
            box-shadow: 0 5px 15px rgba(255, 87, 34, 0.4);
        }
        
        .action-icon {
            font-size: 2rem;
        }
        
        .recent-activity {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .section-title {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.2rem;
            border-bottom: 2px solid #2196F3;
            padding-bottom: 0.5rem;
        }
        
        .activity-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-info {
            flex: 1;
        }
        
        .activity-title {
            font-weight: bold;
            color: #333;
        }
        
        .activity-date {
            color: #666;
            font-size: 0.9rem;
        }
        
        .activity-status {
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .status-active {
            background: #e3f2fd;
            color: #1976d2;
        }
        
        .status-pending {
            background: #fff3e0;
            color: #f57c00;
        }
        
        .status-overdue {
            background: #ffebee;
            color: #c62828;
        }
        
        .nav-menu {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
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
            background: #2196F3;
            color: white;
            border-color: #2196F3;
        }
        
        .admin-section {
            background: #fff3e0;
            border: 2px solid #ff9800;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .admin-title {
            color: #f57c00;
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>🏛️ Bibliothèque - Espace Personnel</h1>
            <div class="user-info">
                <div class="user-avatar">
                    ${utilisateur.nom.charAt(0)}
                </div>
                <div>
                    <div>${utilisateur.nom}</div>
                    <small>${utilisateur.role} - ${utilisateur.typeUtilisateur.nomType}</small>
                </div>
                <a href="/utilisateur/logout" class="logout-btn">Déconnexion</a>
            </div>
        </div>
    </div>
    
    <div class="container">
        <div class="welcome-section">
            <h2 class="welcome-title">Bienvenue, ${utilisateur.nom} !</h2>
            <p>Vous êtes connecté en tant que <strong>${utilisateur.role}</strong>. Dernière connexion: ${utilisateur.derniereConnexion}</p>
        </div>
        
        <div class="nav-menu">
            <a href="#" class="nav-item active">Dashboard</a>
            <a href="/utilisateur/emprunts" class="nav-item">Gestion Emprunts</a>
            <a href="/utilisateur/reservations" class="nav-item">Gestion Réservations</a>
            <a href="/utilisateur/adherents" class="nav-item">Gestion Adhérents</a>
            <a href="/utilisateur/catalogue" class="nav-item">Catalogue</a>
            <a href="/utilisateur/profile" class="nav-item">Mon Profil</a>
        </div>
        
        <% if (utilisateur.role == 'ADMIN') { %>
        <div class="admin-section">
            <h3 class="admin-title">🔧 Section Administrateur</h3>
            <p>Vous avez accès aux fonctionnalités d'administration de la bibliothèque.</p>
        </div>
        <% } %>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">45</div>
                <div class="stat-label">Emprunts actifs</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">12</div>
                <div class="stat-label">Réservations en attente</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">8</div>
                <div class="stat-label">Retours en retard</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">156</div>
                <div class="stat-label">Adhérents actifs</div>
            </div>
        </div>
        
        <div class="actions-grid">
            <a href="/utilisateur/emprunt/nouveau" class="action-btn">
                <div class="action-icon">📚</div>
                <div>Nouvel emprunt</div>
            </a>
            <a href="/utilisateur/retour" class="action-btn">
                <div class="action-icon">📖</div>
                <div>Retour de livre</div>
            </a>
            <a href="/utilisateur/adherent/nouveau" class="action-btn">
                <div class="action-icon">👤</div>
                <div>Nouvel adhérent</div>
            </a>
            <a href="/utilisateur/recherche" class="action-btn">
                <div class="action-icon">🔍</div>
                <div>Recherche</div>
            </a>
            
            <% if (utilisateur.role == 'ADMIN') { %>
            <a href="/utilisateur/admin/livres" class="action-btn admin">
                <div class="action-icon">📚</div>
                <div>Gestion Livres</div>
            </a>
            <a href="/utilisateur/admin/statistiques" class="action-btn admin">
                <div class="action-icon">📊</div>
                <div>Statistiques</div>
            </a>
            <a href="/utilisateur/admin/utilisateurs" class="action-btn admin">
                <div class="action-icon">👥</div>
                <div>Gestion Utilisateurs</div>
            </a>
            <a href="/utilisateur/admin/parametres" class="action-btn admin">
                <div class="action-icon">⚙️</div>
                <div>Paramètres</div>
            </a>
            <% } %>
        </div>
        
        <div class="recent-activity">
            <h3 class="section-title">Activité récente</h3>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Emprunt : Marie Dupont - "Le Petit Prince"</div>
                    <div class="activity-date">Emprunté le 1er juillet 2024</div>
                </div>
                <span class="activity-status status-active">En cours</span>
            </div>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Retour : Pierre Martin - "1984"</div>
                    <div class="activity-date">Retourné le 1er juillet 2024</div>
                </div>
                <span class="activity-status status-active">Terminé</span>
            </div>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Nouvel adhérent : Sophie Bernard</div>
                    <div class="activity-date">Inscrit le 30 juin 2024</div>
                </div>
                <span class="activity-status status-active">Terminé</span>
            </div>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Retard : Jean Dubois - "Harry Potter"</div>
                    <div class="activity-date">Retour prévu le 25 juin 2024</div>
                </div>
                <span class="activity-status status-overdue">En retard</span>
            </div>
        </div>
    </div>
</body>
</html> 