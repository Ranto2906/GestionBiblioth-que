<!DOCTYPE html>
<html>
<head>
    <title>Mes Réservations - Gestion de Bibliothèque</title>
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
            margin-bottom: 2rem;
        }
        
        .btn {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            display: inline-block;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
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
            <a href="/adherent/reservations" class="nav-item active">Mes Réservations</a>
            <a href="/adherent/catalogue" class="nav-item">Catalogue</a>
            <a href="/adherent/profile" class="nav-item">Mon Profil</a>
        </div>
        
        <h1 class="page-title">Mes Réservations</h1>
        
        <div class="empty-state">
            <div class="empty-icon">📚</div>
            <div class="empty-title">Aucune réservation</div>
            <div class="empty-text">
                Vous n'avez pas encore de réservations actives.<br>
                Parcourez notre catalogue pour réserver des livres.
            </div>
            <a href="/adherent/catalogue" class="btn">Parcourir le catalogue</a>
        </div>
    </div>
</body>
</html> 