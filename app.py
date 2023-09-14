from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return {
        "status": 200,
        "data": "flask code"
    }

if __name__ =='__main__':
    app.run('0.0.0.0')