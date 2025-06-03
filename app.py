from flask import Flask, request, jsonify
from datetime import datetime
from flask_cors import CORS
from flask_socketio import SocketIO

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})
socketio = SocketIO(app, cors_allowed_origins="*")

# Тестовые данные
support_requests = [
    {
        "id": "REQ-20240529120000",
        "date": "29.05.2024 12:00",
        "text": "Не могу войти в личный кабинет",
        "status": "Новое",
        "response": None,
        "user": "user1"
    },
    {
        "id": "REQ-20240528150000",
        "date": "28.05.2024 15:00",
        "text": "Проблема с электронной подписью",
        "status": "В работе",
        "response": "Проверьте установку плагина КриптоПро",
        "user": "user1"
    }
]


@app.route('/api/support-requests', methods=['GET', 'POST'])
def handle_requests():
    if request.method == 'POST':
        try:
            data = request.get_json()
            new_request = {
                "id": f"REQ-{datetime.now().strftime('%Y%m%d%H%M%S')}",
                "date": datetime.now().strftime('%d.%m.%Y %H:%M'),
                "text": data['text'],
                "status": "Новое",
                "response": None,
                "user": data.get('user', 'anonymous')
            }
            support_requests.append(new_request)
            socketio.emit('new_request', new_request)
            return jsonify({"success": True, "request": new_request})
        except Exception as e:
            return jsonify({"success": False, "error": str(e)}), 500

    user = request.args.get('user')
    if user:
        return jsonify({"requests": [r for r in support_requests if r['user'] == user]})
    return jsonify({"requests": support_requests})


@app.route('/api/update-request', methods=['POST'])
def update_request():
    try:
        data = request.get_json()
        for req in support_requests:
            if req['id'] == data['id']:
                if 'status' in data:
                    req['status'] = data['status']
                if 'response' in data:
                    req['response'] = data['response']
                socketio.emit('update_request', req)
                return jsonify({"success": True, "request": req})
        return jsonify({"success": False, "error": "Request not found"}), 404
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500


if __name__ == '__main__':
    # Разрешаем использование Werkzeug в development
    socketio.run(app,
                 host='0.0.0.0',
                 port=5000,
                 debug=True,
                 allow_unsafe_werkzeug=True)