import pickle

from sklearn.ensemble import RandomForestRegressor
from flask import Flask, request, jsonify
app = Flask(__name__)

output_file = "/app/model/model.pkl"
with open(output_file, 'rb') as model_file:
	rf = pickle.load(model_file)

@app.route("/", methods=['POST'])
def predict():
    pred_data = request.json
    pred = rf.predict(pred_data)[0]
    return jsonify(pred)


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=5000)


# To request running model:
#import requests
#response = requests.post('http://localhost:5000', json=[[5, 2]]) 
#print(float(response.text))