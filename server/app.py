from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify({
        "status": 200,
        "data": "flask code"
    })

@app.route('/api/login/<name>')
def login(name):
    return jsonify({
        "status": 200,
        "data": name
    })

if __name__ =='__main__':
    app.run(host='0.0.0.0', port=3000)