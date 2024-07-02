from flask import Flask, render_template, request, redirect, url_for, session,g
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker



app = Flask(__name__)
app.secret_key = 'clave'
def dire():
    return 'postgresql://postgres:1234@localhost:5432/postgres'

app.config['SQLALCHEMY_DATABASE_URI'] = dire()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False



db = SQLAlchemy(app)
engine = create_engine(dire())
Session = sessionmaker(bind=engine)
session = Session()

#metodos para abrir y cerrar
def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = db.session
    return db


@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.remove()



@app.route('/')
def home():
    get_db



if __name__ == '__main__':
        
        app.run(debug=True, port=8881)  # se encarga de ejecutar el servidor
