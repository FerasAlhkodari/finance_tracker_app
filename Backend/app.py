from flask import Flask, request, jsonify
from flask_cors import CORS
import plaid

app = Flask(__name__)
CORS(app)  # Enable CORS

# Plaid configuration
PLAID_CLIENT_ID = 'YOUR_PLAID_CLIENT_ID'
PLAID_SECRET = 'YOUR_PLAID_SECRET'
PLAID_ENV = 'sandbox'  # Use 'development' or 'production' for real data

client = plaid.Client(client_id=PLAID_CLIENT_ID,
                      secret=PLAID_SECRET,
                      environment=PLAID_ENV)

# Rest of your endpoints...
