from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import train_test_split
from sklearn import datasets

from flask import Flask, request, jsonify
app = Flask(__name__)


# add parameters for tuning
num_estimators = 100

#TRAIN MODEL:
iris = datasets.load_iris()
x = iris.data[:, 2:]
y = iris.target
X_train, X_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=7)

# train the model
rf = RandomForestRegressor(n_estimators=num_estimators)
rf.fit(X_train, y_train)
predictions = rf.predict(X_test)

@app.route("/", methods=['POST'])
def predict():
    pred_data = request.json
    pred = rf.predict(pred_data)[0]
    return jsonify(pred)


if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=80)


# To request running model:
#import requests
#response = requests.post('http://localhost:80', json=[[5, 2]]) 
#print(float(response.text))