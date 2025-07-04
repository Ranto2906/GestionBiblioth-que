<!DOCTYPE html>
<html>
<head>
    <title>Mes Emprunts - Gestion de Bibliothèque</title>
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
        
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .tabs {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 2rem;
            border-bottom: 2px solid #eee;
        }
        
        .tab {
            padding: 1rem 2rem;
            background: white;
            border: none;
            cursor: pointer;
            border-radius: 10px 10px 0 0;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .tab.active {
            background: #4CAF50;
            color: white;
        }
        
        .tab:hover:not(.active) {
            background: #f0f0f0;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .loan-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
            overflow: hidden;
        }
        
        .loan-header {
            padding: 1.5rem;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .loan-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }
        
        .loan-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .status-en-cours {
            background: #e8f5e8;
            color: #2e7d32;
        }
        
        .status-en-retard {
            background: #ffebee;
            color: #c62828;
        }
        
        .status-termine {
            background: #f3e5f5;
            color: #7b1fa2;
        }
        
        .loan-details {
            padding: 1.5rem;
        }
        
        .loan-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .info-label {
            font-size: 0.8rem;
            color: #666;
            font-weight: bold;
        }
        
        .info-value {
            color: #333;
        }
        
        .loan-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }
        
        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
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
        
        .btn-danger {
            background: #f44336;
            color: white;
        }
        
        .btn-danger:hover {
            background: #d32f2f;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
        
        .empty-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
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
            <a href="/adherent/emprunts" class="nav-item active">Mes Emprunts</a>
            <a href="/adherent/reservations" class="nav-item">Mes Réservations</a>
            <a href="/adherent/catalogue" class="nav-item">Catalogue</a>
            <a href="/adherent/profile" class="nav-item">Mon Profil</a>
        </div>
        
        <h1 class="page-title">Mes Emprunts</h1>
        
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-number">3</div>
                <div class="stat-label">Emprunts actifs</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">0</div>
                <div class="stat-label">En retard</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">15</div>
                <div class="stat-label">Jours restants</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">12</div>
                <div class="stat-label">Emprunts terminés</div>
            </div>
        </div>
        
        <div class="tabs">
            <button class="tab active" onclick="showTab('actifs')">Emprunts actifs</button>
            <button class="tab" onclick="showTab('historique')">Historique</button>
        </div>
        
        <div id="actifs" class="tab-content active">
            <div class="loan-card">
                <div class="loan-header">
                    <div class="loan-title">Le Petit Prince</div>
                    <span class="loan-status status-en-cours">En cours</span>
                </div>
                <div class="loan-details">
                    <div class="loan-info">
                        <div class="info-item">
                            <div class="info-label">Auteur</div>
                            <div class="info-value">Antoine de Saint-Exupéry</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date d'emprunt</div>
                            <div class="info-value">1er juillet 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date de retour</div>
                            <div class="info-value">15 juillet 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Jours restants</div>
                            <div class="info-value">14 jours</div>
                        </div>
                    </div>
                    <div class="loan-actions">
                        <button class="btn btn-primary">Renouveler</button>
                        <button class="btn btn-secondary">Voir détails</button>
                    </div>
                </div>
            </div>
            
            <div class="loan-card">
                <div class="loan-header">
                    <div class="loan-title">1984</div>
                    <span class="loan-status status-en-cours">En cours</span>
                </div>
                <div class="loan-details">
                    <div class="loan-info">
                        <div class="info-item">
                            <div class="info-label">Auteur</div>
                            <div class="info-value">George Orwell</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date d'emprunt</div>
                            <div class="info-value">25 juin 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date de retour</div>
                            <div class="info-value">9 juillet 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Jours restants</div>
                            <div class="info-value">8 jours</div>
                        </div>
                    </div>
                    <div class="loan-actions">
                        <button class="btn btn-primary">Renouveler</button>
                        <button class="btn btn-secondary">Voir détails</button>
                    </div>
                </div>
            </div>
            
            <div class="loan-card">
                <div class="loan-header">
                    <div class="loan-title">Harry Potter à l'école des sorciers</div>
                    <span class="loan-status status-en-cours">En cours</span>
                </div>
                <div class="loan-details">
                    <div class="loan-info">
                        <div class="info-item">
                            <div class="info-label">Auteur</div>
                            <div class="info-value">J.K. Rowling</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date d'emprunt</div>
                            <div class="info-value">20 juin 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date de retour</div>
                            <div class="info-value">4 juillet 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Jours restants</div>
                            <div class="info-value">3 jours</div>
                        </div>
                    </div>
                    <div class="loan-actions">
                        <button class="btn btn-primary">Renouveler</button>
                        <button class="btn btn-secondary">Voir détails</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="historique" class="tab-content">
            <div class="loan-card">
                <div class="loan-header">
                    <div class="loan-title">Le Seigneur des Anneaux</div>
                    <span class="loan-status status-termine">Terminé</span>
                </div>
                <div class="loan-details">
                    <div class="loan-info">
                        <div class="info-item">
                            <div class="info-label">Auteur</div>
                            <div class="info-value">J.R.R. Tolkien</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date d'emprunt</div>
                            <div class="info-value">1er mai 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Date de retour</div>
                            <div class="info-value">15 mai 2024</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Statut</div>
                            <div class="info-value">Retourné à temps</div>
                        </div>
                    </div>
                    <div class="loan-actions">
                        <button class="btn btn-secondary">Voir détails</button>
                        <button class="btn btn-primary">Réemprunter</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function showTab(tabName) {
            // Masquer tous les contenus d'onglets
            const tabContents = document.querySelectorAll('.tab-content');
            tabContents.forEach(content => {
                content.classList.remove('active');
            });
            
            // Désactiver tous les onglets
            const tabs = document.querySelectorAll('.tab');
            tabs.forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Afficher l'onglet sélectionné
            document.getElementById(tabName).classList.add('active');
            
            // Activer le bouton d'onglet correspondant
            event.target.classList.add('active');
        }
    </script>
</body>
</html> 