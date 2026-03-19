from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    name = os.getenv('USER_NAME', 'Alexis')
    return f"Bonjour {name} ! L'API fonctionne."

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)