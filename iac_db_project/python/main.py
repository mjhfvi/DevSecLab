"""
this code will run a flask web application,
connecting to a postgresql and run a select command to
list all the values in the employees db
"""
from __future__ import annotations

import json
import os
import sys

import psycopg2.extras
from flask import Flask
from flask import jsonify
from flask import redirect
from flask import render_template
from flask import request
from flask import url_for

app = Flask(__name__)

# health check status
health_status = True
file_path = 'version.json'
file = open(file_path)
data = json.load(file)


@app.route('/health')
def health():
    if health_status:
        resp = jsonify(health='healthy')
        resp.status_code = 200
        return jsonify(version=data)
    else:
        resp = jsonify(health='unhealthy')
        resp.status_code = 500
    return resp


# database connection parameters
_PORT_DB = os.getenv('PORT_DB_VAR', default='5432')
_HOST = os.getenv('HOST_VAR', default='localhost')
_DB = os.getenv('DB_VAR', default='flaskappdb')
_PASSWORD = os.getenv('PASSWORD_VAR', default='12345')
_USER = os.getenv('USER_VAR', default='flaskappuser')
_PORT_FLASK = int(os.getenv('PORT_VAR', default='5000'))

DATABASE_URL = f'dbname={_DB} user={_USER} host={_HOST} port={_PORT_DB} password={_PASSWORD}'
connection = psycopg2.connect(DATABASE_URL)


@app.route('/favicon.ico')
def favicon():
    return url_for('static', filename='image/favicon.ico')


@app.route('/')
def employee_list():
    """definition to connect to the database and run a select command """
    command = connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
    command.execute('SELECT * FROM employee')
    employee_data = command.fetchall()
    command.close()
    # connection.close()
    return render_template('index.html', employee=employee_data)


# @app.route('/form', methods=('GET', 'POST'))
# def create():
#     if request.method == 'POST':
#         if request.form['submit_button'] == 'Do Something':
#             firstname = request.form.get('firstname')
#             lastname = request.form.get('lastname')
#             # conn = get_db_connection()
#             cursor = connection.cursor()
#             cursor.execute("INSERT INTO employee (firstname, lastname) VALUES (%s, %s)", (firstname, lastname))
#             connection.commit()
#             cursor.close()
#             connection.close()
#             return redirect(url_for('index'))
#     return render_template('form.html')

@app.route('/form_new_user')
def form_new_user():
    return render_template('form_new_user.html')


@app.route('/create', methods=['POST'])
def create():
    if request.method == 'POST':
        cursor = connection.cursor()
        firstname = request.form['firstname']
        lastname = request.form['lastname']
        age = request.form['age']
        address = request.form['address']
        workplace = request.form['workplace']
        cursor.execute('''INSERT INTO employee (firstname, lastname, age, address, workplace) VALUES (%s, %s, %s, %s, %s)''',
                       (firstname, lastname, age, address, workplace))
        connection.commit()
        # cursor.close()
        # connection.close()
        return redirect(url_for('employee_list'))


@app.route('/form_delete_user')
def form_delete_user():
    return render_template('form_delete_user.html')


@app.route('/delete', methods=['POST'])
def delete():
    cursor = connection.cursor()
    id = request.form['id']
    cursor.execute('''DELETE FROM employee WHERE id=%s''', (id,))
    connection.commit()
    # cursor.close()
    # connection.close()
    return redirect(url_for('employee_list'))


@app.route('/about')
def about():
    return render_template('about.html')


if __name__ == '__main__':
    print(f'Using System Environments: \n'
          f"Host Name: '{_HOST}'"
          f"\nPort Number: '{_PORT_FLASK}'"
          f"\nDatabase Name: '{_DB}'"
          f"\nDatabase Port: '{_PORT_DB}'"
          f"\nUser Name: '{_USER}'")

    app.run(host='0.0.0.0', port=_PORT_FLASK, debug=True)
    # connection.close()
    sys.exit(0)
