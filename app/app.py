from flask import Flask, jsonify
import os
import socket
import platform
import datetime

app = Flask(__name__)

@app.route('/')
def home():
    """Route par défaut qui présente l'API."""
    return jsonify({
        "message": "Bienvenue sur l'API de monitoring de mon Cluster AKS",
        "status": "Running",
        "timestamp": datetime.datetime.now().isoformat(),
        "endpoints": {
            "info": "/info (Détails techniques du Pod)",
            "health": "/health (Liveness check)"
        }
    })

@app.route('/info')
def get_info():
    """Expose les données techniques de l'infrastructure."""
    return jsonify({
        "hostname": socket.gethostname(),
        "ip_interne": socket.gethostbyname(socket.gethostname()),
        "os": platform.system(),
        "architecture": platform.machine(),
        "cpu_count": os.cpu_count(),
        "python_version": platform.python_version(),
        "env_vars": {
            "flask_env": os.environ.get("FLASK_ENV", "production"),
            "port_config": os.environ.get("PORT", "5000")
        }
    })

@app.route('/health')
def health():
    """Route de check pour Kubernetes."""
    return "OK", 200

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    # host='0.0.0.0' est crucial pour être accessible hors du conteneur
    app.run(host='0.0.0.0', port=port)