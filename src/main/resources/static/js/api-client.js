// Fonction utilitaire pour formater les dates
function formatDate(dateString) {
    if (!dateString) return '-';
    const date = new Date(dateString);
    return date.toLocaleDateString('fr-FR');
}

function formatDateTime(dateString) {
    if (!dateString) return '-';
    const date = new Date(dateString);
    return date.toLocaleDateString('fr-FR') + ' ' + date.toLocaleTimeString('fr-FR');
}

// Fonction générique pour les appels AJAX
function makeAjaxCall(method, url, successCallback, errorCallback) {
    const xhr = new XMLHttpRequest();
    xhr.open(method, url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    successCallback(response);
                } catch (e) {
                    errorCallback('Erreur lors du traitement de la réponse');
                }
            } else if (xhr.status === 404) {
                errorCallback('Ressource non trouvée');
            } else {
                errorCallback('Une erreur est survenue');
            }
        }
    };

    xhr.onerror = function () {
        errorCallback('Erreur de connexion au serveur');
    };

    xhr.send();
}

// Fonction pour récupérer les détails d'un livre
function getLivreDetails(livreId, successCallback, errorCallback) {
    makeAjaxCall(
        'GET',
        `/api/livres/${livreId}`,
        successCallback,
        errorCallback
    );
}

// Fonction pour récupérer les détails d'un adhérent
function getAdherentDetails(numeroAdherent, successCallback, errorCallback) {
    makeAjaxCall(
        'GET',
        `/api/adherents/${numeroAdherent}`,
        successCallback,
        errorCallback
    );
} 