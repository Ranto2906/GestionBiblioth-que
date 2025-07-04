<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Adhérent - Gestion de Bibliothèque</title>
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
        
        .welcome-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .welcome-title {
            color: #4CAF50;
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
            color: #4CAF50;
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
            background: linear-gradient(135deg, #4CAF50, #45a049);
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
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
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
            border-bottom: 2px solid #4CAF50;
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
            background: #e8f5e8;
            color: #2e7d32;
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
        <div class="welcome-section">
            <h2 class="welcome-title">Bienvenue, ${adherent.prenom} !</h2>
            <p>Votre adhésion expire le ${adherent.dateExpirationAdhesion}. Statut: 
                <span class="activity-status status-active">${adherent.statut}</span>
            </p>
        </div>
        
        <div class="nav-menu">
            <a href="#" class="nav-item active">Dashboard</a>
            <a href="/adherent/emprunts" class="nav-item">Mes Emprunts</a>
            <a href="/adherent/reservations" class="nav-item">Mes Réservations</a>
            <a href="/adherent/catalogue" class="nav-item">Catalogue</a>
            <a href="/adherent/profile" class="nav-item">Mon Profil</a>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">3</div>
                <div class="stat-label">Livres empruntés</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">2</div>
                <div class="stat-label">Réservations actives</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">15</div>
                <div class="stat-label">Jours restants</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">0</div>
                <div class="stat-label">Retards</div>
            </div>
        </div>
        
        <div class="actions-grid">
            <a href="/adherent/emprunter" class="action-btn">
                <div class="action-icon">📚</div>
                <div>Emprunter un livre</div>
            </a>
            <a href="/adherent/reserver" class="action-btn">
                <div class="action-icon">🔖</div>
                <div>Réserver un livre</div>
            </a>
            <a href="/adherent/catalogue" class="action-btn">
                <div class="action-icon">🔍</div>
                <div>Rechercher</div>
            </a>
            <a href="/adherent/historique" class="action-btn">
                <div class="action-icon">📋</div>
                <div>Mon historique</div>
            </a>
        </div>
        
        <div class="recent-activity">
            <h3 class="section-title">Activité récente</h3>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Emprunt : "Le Petit Prince"</div>
                    <div class="activity-date">Retour prévu le 15 juillet 2024</div>
                </div>
                <span class="activity-status status-active">En cours</span>
            </div>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Réservation : "1984"</div>
                    <div class="activity-date">Disponible le 10 juillet 2024</div>
                </div>
                <span class="activity-status status-pending">En attente</span>
            </div>
            <div class="activity-item">
                <div class="activity-info">
                    <div class="activity-title">Retour : "Harry Potter"</div>
                    <div class="activity-date">Retourné le 1er juillet 2024</div>
                </div>
                <span class="activity-status status-active">Terminé</span>
            </div>
        </div>
    </div>
</body>
</html> 