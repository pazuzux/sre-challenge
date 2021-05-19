from os import getenv
from flask import Flask
app = Flask(__name__)

VAR_1 = getenv('VAR_1', "Estou")
VAR_2 = getenv('VAR_2', "rodando")
VAR_3 = getenv('VAR_3', "em Docker!!!")
POD_NAME = getenv('MY_POD_NAME', "")

@app.route("/")
def index():
    return "Hello World! " + VAR_1 + " " + VAR_2 + " " + VAR_3 + " " + POD_NAME 

