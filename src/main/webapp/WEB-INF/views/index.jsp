<!DOCTYPE html>
<html>
<head>
    <title>Accueil - Gestion de Bibliothèque</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 2.5em;
        }
        
        .login-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .login-btn {
            padding: 15px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            min-width: 150px;
        }
        
        .btn-adherent {
            background: linear-gradient(45deg, #4CAF50, #45a049);
            color: white;
        }
        
        .btn-adherent:hover {
            background: linear-gradient(45deg, #45a049, #3d8b40);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        }
        
        .btn-utilisateur {
            background: linear-gradient(45deg, #2196F3, #1976D2);
            color: white;
        }
        
        .btn-utilisateur:hover {
            background: linear-gradient(45deg, #1976D2, #1565C0);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.4);
        }
        
        .description {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1> Gestion de Bibliotheque</h1>
        <p class="description">
            Bienvenue dans notre systeme de gestion de bibliotheque.<br>
            Veuillez selectionner votre type de compte pour continuer.
        </p>
        
        <div class="login-buttons">
            <a href="/login-adherent" class="login-btn btn-adherent">
                 Connexion Adherent
            </a>
            <a href="/login-utilisateur" class="login-btn btn-utilisateur">
                 Connexion Utilisateur
            </a>
        </div>
    </div>
</body>
</html>
