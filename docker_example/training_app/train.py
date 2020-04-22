import pickle

from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn import datasets

output_file = "/app/model/model.pkl"

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
y_pred = rf.predict(X_test)
print("MSE:")
print(mean_squared_error(y_test, y_pred))

with open(output_file, 'wb') as model_file:
	pickle.dump(rf, model_file)
