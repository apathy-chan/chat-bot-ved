from flask import Flask, request, jsonify
from datetime import datetime
from flask_cors import CORS
from flask_socketio import SocketIO
import sqlite3

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "*"}})
socketio = SocketIO(app, cors_allowed_origins="*")

def get_db_connection():
    conn = sqlite3.connect('chatbot.db')
    conn.row_factory = sqlite3.Row

    # Проверяем существование таблицы spp_requests и создаем если нет
    cursor = conn.cursor()
    cursor.execute("""
        SELECT name FROM sqlite_master 
        WHERE type='table' AND name='spp_requests'
    """)
    if not cursor.fetchone():
        cursor.execute("""
            CREATE TABLE spp_requests (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                section_id TEXT NOT NULL,
                question TEXT NOT NULL,
                answer TEXT,
                status TEXT NOT NULL,
                date_added TEXT NOT NULL
            )
        """)
        conn.commit()

    return conn


@app.route('/api/support-requests', methods=['GET', 'POST'])  # ← Добавлен POST
def handle_support_requests():
    if request.method == 'POST':
        # Обработка POST-запроса (отправка нового вопроса)
        try:
            data = request.get_json()
            if not data or 'question' not in data:
                return jsonify({"success": False, "error": "Не указан текст вопроса"}), 400

            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute(
                '''INSERT INTO spp_requests (section_id, question, answer, status, date_added) 
                VALUES (?, ?, ?, ?, ?)''',
                (data.get('section_id', 'other'),
                 data['question'],
                 '',
                 data.get('status', 'new'),
                 datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
            )
            new_id = cursor.lastrowid
            conn.commit()
            conn.close()

            return jsonify({"success": True, "id": new_id})

        except Exception as e:
            return jsonify({"success": False, "error": str(e)}), 500

    elif request.method == 'GET':
        # Обработка GET-запроса (получение списка вопросов)
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute('SELECT * FROM spp_requests ORDER BY date_added DESC')
            requests = [dict(row) for row in cursor.fetchall()]
            conn.close()
            return jsonify({"success": True, "requests": requests})

        except Exception as e:
            return jsonify({"success": False, "error": str(e)}), 500


@app.route('/api/update-spp-request', methods=['POST'])
def update_spp_request():
    try:
        data = request.get_json()
        if not data or 'id' not in data:
            return jsonify({"success": False, "error": "Не указан ID записи"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()

        # Проверяем существование записи
        cursor.execute('SELECT * FROM spp_requests WHERE id = ?', (data['id'],))
        if not cursor.fetchone():
            conn.close()
            return jsonify({"success": False, "error": "Запись не найдена"}), 404

        # Обновляем только указанные поля
        answer = data.get('answer')
        status = data.get('status')

        update_fields = []
        update_values = []

        if answer is not None:
            update_fields.append("answer = ?")
            update_values.append(answer)

        if status is not None:
            update_fields.append("status = ?")
            update_values.append(status)

        if not update_fields:
            conn.close()
            return jsonify({"success": False, "error": "Не указаны поля для обновления"}), 400

        update_values.append(data['id'])
        update_query = f"UPDATE spp_requests SET {', '.join(update_fields)} WHERE id = ?"

        cursor.execute(update_query, update_values)
        conn.commit()
        conn.close()

        return jsonify({"success": True})
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500


if __name__ == '__main__':
    socketio.run(app,
                 host='0.0.0.0',
                 port=5000,
                 debug=True,
                 allow_unsafe_werkzeug=True)