from flask import Flask, request, jsonify, render_template
import json
from difflib import get_close_matches
from datetime import datetime
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Глобальная переменная для хранения обращений
support_requests = [
    {
        'id': 'A/000244491',
        'date': '24.04.2025 14:22',
        'status': 'Запрос закрытия',
        'text': '181-358-994 О2 хламная мазь gkfugfdog',
        'response': 'Ваш запрос обработан'
    },
    {
        'id': 'A/000244492',
        'date': '26.04.2025 09:15',
        'status': 'Новое обращение',
        'text': 'Проблема с авторизацией в личном кабинете',
        'response': None
    }
]

def load_data():
    try:
        with open('FAQ.json', 'r', encoding='utf-8') as f:
            data = json.load(f)
        # Создаем структуру для поиска по разделам
        sections_data = {}
        for section in data['sections']:
            questions_dict = {}
            for q in section['questions']:
                questions_dict[q['question'].lower()] = {
                    'answer': q['answer']['text'],
                    'section': section['id']
                }
            sections_data[section['id']] = {
                'name': section['name'],
                'questions': questions_dict
            }
        return sections_data
    except Exception as e:
        print(f"Error loading FAQ data: {e}")
        return {}

def get_answer(question, data, current_section=None):
    if not data:
        return {
            "answer": "Извините, в данный момент база знаний недоступна.",
            "section": None,
            "source": "error"
        }
    question = question.lower()
    # Сначала ищем в текущем разделе, если он указан
    if current_section and current_section in data:
        section_questions = data[current_section]['questions']
        if question in section_questions:
            return {
                "answer": section_questions[question]['answer'],
                "section": current_section,
                "source": "exact"
            }
        matches = get_close_matches(question, section_questions.keys(), n=1, cutoff=0.6)
        if matches:
            return {
                "answer": section_questions[matches[0]]['answer'],
                "section": current_section,
                "source": "close"
            }
    # Если не нашли в текущем разделе, ищем во всех разделах
    for section_id, section in data.items():
        if question in section['questions']:
            return {
                "answer": section['questions'][question]['answer'],
                "section": section_id,
                "source": "exact"
            }
        matches = get_close_matches(question, section['questions'].keys(), n=1, cutoff=0.6)
        if matches:
            return {
                "answer": section['questions'][matches[0]]['answer'],
                "section": section_id,
                "source": "close"
            }
    return {
        "answer": "Извините, не могу найти ответ в базе знаний.",
        "section": None,
        "source": "no_match"
    }

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/support')
def support():
    return render_template('SPP.html')

@app.route('/ask', methods=['POST'])
def ask():
    try:
        user_question = request.form['question']
        current_section = request.form.get('current_section')
        data = load_data()
        result = get_answer(user_question, data, current_section)
        # Добавляем название раздела в ответ, если вопрос найден
        if result['section']:
            result['section_name'] = data[result['section']]['name']
        return jsonify(result)
    except Exception as e:
        print(f"Error processing question: {e}")
        return jsonify({
            "answer": "Произошла ошибка при обработке вашего вопроса.",
            "section": None,
            "source": "error"
        }), 500


@app.route('/add_request', methods=['POST'])
def add_request():
    try:
        text = request.json.get('text')
        if not text or len(text.strip()) < 5:
            return jsonify({'success': False, 'error': 'Текст запроса слишком короткий'}), 400

        # Генерируем номер запроса
        request_id = f"REQ-{datetime.now().strftime('%Y%m%d-%H%M%S')}"

        new_request = {
            'id': request_id,
            'date': datetime.now().strftime('%d.%m.%Y %H:%M'),
            'status': 'Новое обращение',
            'text': text.strip(),
            'response': None
        }

        support_requests.insert(0, new_request)
        return jsonify({
            'success': True,
            'request': new_request
        })
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/get_requests', methods=['GET'])
def get_requests():
    try:
        return jsonify({'requests': support_requests})
    except Exception as e:
        print(f"Error getting support requests: {e}")
        return jsonify({'requests': []}), 500

@app.route('/update_request', methods=['POST'])
def update_request():
    try:
        data = request.json
        request_id = data.get('id')
        status = data.get('status')
        response = data.get('response')

        if not request_id:
            return jsonify({'success': False, 'error': 'Missing request ID'}), 400

        for req in support_requests:
            if req['id'] == request_id:
                if status:
                    req['status'] = status
                if response:
                    req['response'] = response
                return jsonify({'success': True})
        return jsonify({'success': False, 'error': 'Request not found'}), 404
    except Exception as e:
        print(f"Error updating request: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/sections', methods=['GET'])
def get_sections():
    try:
        data = load_data()
        sections = [{'id': k, 'name': v['name']} for k, v in data.items()]
        return jsonify({'sections': sections})
    except Exception as e:
        print(f"Error getting sections: {e}")
        return jsonify({'sections': []}), 500

@app.route('/notify_user', methods=['POST'])
def notify_user():
    try:
        data = request.json
        if not data or not data.get('id'):
            return jsonify({'success': False, 'error': 'Invalid request data'}), 400

        print(f"Notify user for request {data.get('id')}: {data.get('message')}")
        return jsonify({'success': True})
    except Exception as e:
        print(f"Error notifying user: {e}")
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/welcome', methods=['POST'])
def welcome():
    try:
        data = load_data()
        section_id = request.json.get('section_id') if request.json else None
        welcome_text = "Здравствуйте! Меня зовут ЧаВоВЭд-бот. Я помогу вам найти информацию по часто задаваемым вопросам."

        if section_id and section_id in data:
            section_name = data[section_id]['name']
            keywords = list(data[section_id]['questions'].keys())
            keywords_list = ', '.join(keywords[:8]) if keywords else "ключевые слова не найдены"
            message = (
                f"{welcome_text}\n\n"
                f"Вы сейчас в разделе «{section_name}».\n"
                f"Вот список ключевых слов по этому разделу, которые помогут найти ответ на вопрос:\n"
                f"{keywords_list}"
            )
        else:
            section_names = [v['name'] for v in data.values()]
            message = (
                    f"{welcome_text}\n\n"
                    "Пожалуйста, выберите интересующий вас раздел:\n" +
                    "\n".join(f"- {name}" for name in section_names)
            )
        return jsonify({'message': message})
    except Exception as e:
        print(f"Error in welcome: {e}")
        return jsonify({'message': 'Ошибка при формировании приветственного сообщения.'}), 500

@app.route('/check_more_questions', methods=['POST'])
def check_more_questions():
    try:
        return jsonify({
            "message": "Остались еще вопросы?",
            "options": ["Да", "Нет"]
        })
    except Exception as e:
        print(f"Error in check_more_questions: {e}")
        return jsonify({"message": "Произошла ошибка", "options": []}), 500

if __name__ == '__main__':
    app.run(debug=True)