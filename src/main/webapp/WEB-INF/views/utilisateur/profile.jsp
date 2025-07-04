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
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 2rem;
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
        
        .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .profile-header {
            background: linear-gradient(135deg, #2196F3 0%, #1976D2 100%);
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
        
        .profile-role {
            opacity: 0.9;
        }
        
        .profile-content {
            padding: 2rem;
        }
        
        .section-title {
            color: #2196F3;
            margin-bottom: 1.5rem;
            font-size: 1.2rem;
            border-bottom: 2px solid #2196F3;
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
        
        .role-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }
        
        .role-admin {
            background: #ffebee;
            color: #c62828;
        }
        
        .role-bibliothecaire {
            background: #e3f2fd;
            color: #1976d2;
        }
        
        .role-assistant {
            background: #e8f5e8;
            color: #2e7d32;
        }
        
        .edit-btn {
            background: linear-gradient(135deg, #2196F3, #1976D2);
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
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.4);
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
        
        .permissions-list {
            list-style: none;
            padding: 0;
        }
        
        .permissions-list li {
            padding: 0.5rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .permissions-list li:last-child {
            border-bottom: none;
        }
        
        .permission-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .permission-icon {
            color: #4CAF50;
            font-weight: bold;
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
        <div class="nav-menu">
            <a href="/utilisateur/dashboard" class="nav-item">Dashboard</a>
            <a href="/utilisateur/emprunts" class="nav-item">Gestion Emprunts</a>
            <a href="/utilisateur/reservations" class="nav-item">Gestion Réservations</a>
            <a href="/utilisateur/adherents" class="nav-item">Gestion Adhérents</a>
            <a href="/utilisateur/catalogue" class="nav-item">Catalogue</a>
            <a href="/utilisateur/profile" class="nav-item active">Mon Profil</a>
        </div>
        
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    ${utilisateur.nom.charAt(0)}
                </div>
                <div class="profile-name">${utilisateur.nom}</div>
                <div class="profile-role">${utilisateur.role} - ${utilisateur.typeUtilisateur.nomType}</div>
            </div>
            
            <div class="profile-content">
                <h3 class="section-title">Informations professionnelles</h3>
                
                <div class="info-grid">
                    <div class="info-group">
                        <div class="info-label">Nom d'utilisateur</div>
                        <div class="info-value">${utilisateur.nom}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Rôle</div>
                        <div class="info-value">
                            <span class="role-badge role-${utilisateur.role.toLowerCase()}">${utilisateur.role}</span>
                        </div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Type d'utilisateur</div>
                        <div class="info-value">${utilisateur.typeUtilisateur.nomType}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Date de création</div>
                        <div class="info-value">${utilisateur.dateCreation}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Dernière connexion</div>
                        <div class="info-value">${utilisateur.derniereConnexion}</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Statut</div>
                        <div class="info-value">
                            <span class="role-badge role-${utilisateur.actif ? 'active' : 'inactive'}">
                                ${utilisateur.actif ? 'Actif' : 'Inactif'}
                            </span>
                        </div>
                    </div>
                </div>
                
                <% if (utilisateur.role == 'ADMIN') { %>
                <div class="admin-section">
                    <h3 class="admin-title">🔧 Permissions Administrateur</h3>
                    <p>En tant qu'administrateur, vous avez accès à toutes les fonctionnalités du système :</p>
                    <ul class="permissions-list">
                        <li>
                            <div class="permission-item">
                                <span class="permission-icon">✓</span>
                                <span>Gestion complète des utilisateurs et adhérents</span>
                            </div>
                        </li>
                        <li>
                            <div class="permission-item">
                                <span class="permission-icon">✓</span>
                                <span>Gestion du catalogue et des exemplaires</span>
                            </div>
                        </li>
                        <li>
                            <div class="permission-item">
                                <span class="permission-icon">✓</span>
                                <span>Configuration des paramètres système</span>
                            </div>
                        </li>
                        <li>
                            <div class="permission-item">
                                <span class="permission-icon">✓</span>
                                <span>Accès aux statistiques et rapports</span>
                            </div>
                        </li>
                        <li>
                            <div class="permission-item">
                                <span class="permission-icon">✓</span>
                                <span>Gestion des types d'utilisateurs et droits</span>
                            </div>
                        </li>
                    </ul>
                </div>
                <% } else { %>
                <h3 class="section-title">Permissions</h3>
                <div class="info-grid">
                    <div class="info-group">
                        <div class="info-label">Gestion des emprunts</div>
                        <div class="info-value">Autorisé</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Gestion des réservations</div>
                        <div class="info-value">Autorisé</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Gestion des adhérents</div>
                        <div class="info-value">Autorisé</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Consultation du catalogue</div>
                        <div class="info-value">Autorisé</div>
                    </div>
                    
                    <div class="info-group">
                        <div class="info-label">Administration système</div>
                        <div class="info-value">Non autorisé</div>
                    </div>
                </div>
                <% } %>
                
                <div class="button-group">
                    <a href="/utilisateur/dashboard" class="back-btn">← Retour au Dashboard</a>
                    <button class="edit-btn" onclick="alert('Fonctionnalité de modification à implémenter')">
                        Modifier mon profil
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 