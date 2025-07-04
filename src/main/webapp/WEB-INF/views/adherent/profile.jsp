<!DOCTYPE html>
<html>
<head>
    <title>Mon Profil - Gestion de Bibliothèque</title>
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
            max-width: 800px;
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
        
        .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: bold;
            margin: 0 auto 1rem;
        }
        
        .profile-name {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        
        .profile-type {
            opacity: 0.9;
        }
        
        .profile-content {
            padding: 2rem;
        }
        
        .section-title {
            color: #4CAF50;
            margin-bottom: 1.5rem;
            font-size: 1.2rem;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 0.5rem;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .info-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .info-label {
            font-weight: bold;
            color: #666;
            font-size: 0.9rem;
        }
        
        .info-value {
            color: #333;
            font-size: 1rem;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .status-active {
            background: #e8f5e8;
            color: #2e7d32;
        }
        
        .status-suspendu {
            background: #ffebee;
            color: #c62828;
        }
        
        .edit-btn {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .edit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        }
        
        .back-btn {
            background: #666;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            display: inline-block;
            margin-right: 1rem;
        }
        
        .back-btn:hover {
            background: #555;
        }
        
        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
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
            <a href="/adherent/catalogue" class="nav-item">Catalogue</a>
            <a href="/adherent/profile" class="nav-item active">Mon Profil</a>
        </div>
        
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    ${adherent.prenom.charAt(0)}${adherent.nom.charAt(0)}
                </div>
                <div class="profile-name">${adherent.prenom} ${adherent.nom}</div>
                <div class="profile-type">${adherent.typeUtilisateur.nomType}</div>
            </div>
            
            <div class="profile-content">
                <h3 class="section-title">Informations personnelles</h3>
                
                <div class="info-grid">
                    <div class="info-group">
                        <div class="info-label">Nom</div>
                        <div class="info-value">${adherent.nom}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Prénom</div>
                        <div class="info-value">${adherent.prenom}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Email</div>
                        <div class="info-value">${adherent.email}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Type d'adhérent</div>
                        <div class="info-value">${adherent.typeUtilisateur.nomType}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Date d'inscription</div>
                        <div class="info-value">${adherent.dateInscription}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Expiration de l'adhésion</div>
                        <div class="info-value">${adherent.dateExpirationAdhesion}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Statut</div>
                        <div class="info-value">
                            <span class="status-badge status-${adherent.statut.toLowerCase()}">${adherent.statut}</span>
                        </div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Préférences de notification</div>
                        <div class="info-value">
                            ${adherent.preferencesNotification != null ? adherent.preferencesNotification : 'Aucune préférence définie'}
                        </div>
                    </div>
                </div>
                
                <h3 class="section-title">Droits d'emprunt</h3>
                
                <div class="info-grid">
                    <div class="info-group">
                        <div class="info-label">Durée d'emprunt</div>
                        <div class="info-value">${adherent.typeUtilisateur.dureeEmpruntJours} jours</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Nombre d'emprunts maximum</div>
                        <div class="info-value">${adherent.typeUtilisateur.nombreEmpruntsMax} livres</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Nombre de renouvellements</div>
                        <div class="info-value">${adherent.typeUtilisateur.nombreRenouvellementsMax} fois</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Peut réserver</div>
                        <div class="info-value">${adherent.typeUtilisateur.peutReserver ? 'Oui' : 'Non'}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Priorité de réservation</div>
                        <div class="info-value">${adherent.typeUtilisateur.prioriteReservation}</div>
                    </div>
                </div>
                
                <div class="button-group">
                    <a href="/adherent/dashboard" class="back-btn">← Retour au Dashboard</a>
                    <button class="edit-btn" onclick="alert('Fonctionnalité de modification à implémenter')">
                        Modifier mon profil
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 