from flask import Flask,g
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
def dire():
    return 'postgresql://postgres:1234@localhost:5432/postgres'

app.config['SQLALCHEMY_DATABASE_URI'] = dire()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
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

from sqlalchemy import Boolean, Column, Date, Integer, String


from sqlalchemy.orm import declarative_base
Base = declarative_base()


class User(Base):
    __tablename__ = 'users'

    
    no_tarjeta = Column(Integer, primary_key=True, nullable=False)
    clave_acces = Column(Integer, nullable=False)

class UsuarioMaxin:
    no_tarjeta = db.Column(db.Integer,primary_key=True)


class Asistente(Base):
    __tablename__ = 'asistente'
    no_tarjeta = Column(Integer, primary_key=True)
    no_chef_jefe = Column(Integer, nullable=False)
    clave_acces = Column(Integer, nullable=False)
    confirmacion_asis = Column(Boolean, nullable=False)
    id_participante = Column(Integer, nullable=False)
    nombre = Column(String, nullable=False)

class Chef(Base):
    __tablename__ = 'chef'
      
    no_tarjeta = Column(Integer, primary_key=True)
    clave_acces = Column(Integer, nullable=False)
    tarjetas_asistentes = Column(Integer, nullable=False)
    n_receta = Column(String,nullable=False)
    nombre = Column(String, nullable=False)


class Evento(Base):
    __tablename__ = 'evento'
    nombre = Column(String, primary_key=True)
    id_patrocinadores = Column(Integer, nullable=False)
    fecha = Column(Date, nullable=False)
    id_asistentes_confirmados = Column(Integer, nullable=False)


class Ingredientes(Base):
    __tablename__ = 'ingredientes'
    nombreingr = Column(String, primary_key=True)
    descripcion = Column(String, nullable=False)


class Organizador(Base):
    __tablename__ = 'organiador'
    nombre = Column(String, nullable=False)
    apellido = Column(String, nullable=False)
    no_tarjeta_orga = Column(Integer, primary_key=True)
    clave_acces = Column(Integer,nullable=True)

class Organizador1(Base):
    __tablename__ = 'organiador1'
    nombre = Column(String, nullable=False)
    apellido = Column(String, nullable=False)
    no_tarjeta_orga = Column(Integer, primary_key=True)




class Organizador2(Base):
    __tablename__ = 'organiador2'
    nombre = Column(String, nullable=False)
    apellido = Column(String, nullable=False)
    no_tarjeta_orga = Column(Integer, primary_key=True)



class Organizador3(Base):
    __tablename__ = 'organiador3'
    nombre = Column(String, nullable=False)
    apellido = Column(String, nullable=False)
    no_tarjeta_orga = Column(Integer, primary_key=True)




class Participante(Base):
    __tablename__ = 'participante'
    no_tarjeta = Column(Integer, primary_key=True)
    clave_de_acces = Column(Integer, nullable=False)
    nombre_evento = Column(String, nullable=False)


class Patrocinador(Base):
    __tablename__ = 'patrocinador'
    nombre = Column(String, nullable=False)
    ido = Column(Integer, primary_key=True)
    apllido = Column(String, nullable=False)
    clave_acces = Column(Integer, nullable=False)
    nombre_event = Column(String)

class Receta(Base):
    __tablename__ = 'receta'
    nombre_receta = Column(String, primary_key=True)
    descripcion = Column(String)

class Utiliza(Base):
    __tablename__ = 'utiliza'
    id_utiliza = Column(Integer, primary_key=True)
    nombre_ingredientes = Column(String, nullable=False)
    recetas = Column(String, nullable=False)


class Administrador(UsuarioMaxin,Base):
    __tablename__ = 'administrador'
    def __init__(self,**kwargs):
        super.__init__(**kwargs)
    id = Column(Integer,primary_key= True)
    def __repr__(self):
        return '<Administrador {}>'.format(self.id)
    
