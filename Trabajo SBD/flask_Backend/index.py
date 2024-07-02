from flask import Flask, json, request, g, render_template, redirect, session, url_for, flash
from flask_sqlalchemy import SQLAlchemy
import psycopg2
from requests import Session
from sqlalchemy.orm import sessionmaker
from sqlalchemy import text,create_engine
from sqlalchemy.ext.declarative import declarative_base
from flask import jsonify
import config
from models import modelos
from models.crud_model import CrudModel  # Import the CrudModel class from crud_model.py


# Coneccion a la Base de datdos
app = Flask(__name__)

app.config['TEMPLATES_FOLDER'] = 'templates'

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


# instancia de crud_models
chefs = CrudModel('chef')  
asistentes=CrudModel('asistente')
patrocinadores=CrudModel('patrocinador')
organizadores=CrudModel('organizador')
recetas=CrudModel('receta')
ingredientes=CrudModel('ingredientes')
eventos=CrudModel('evento')

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.remove()


# Rutas 
@app.route('/')
def index():
    return redirect(url_for('home'))

#esta ruta nos dara el nombre del evento :|
@app.route('/home')
async def home():
    get_db
    resp = await eventos.get_columns()
    return jsonify(resp)


#consultar los asistentes
@app.route('/asistentes')
async def obtener_asistentes():
    get_db
    resp = await asistentes.get_all()

     
    return render_template('asistentes.html', asistentes=resp)
 

#consultar los chefs
@app.route('/chefs')
async def obtener_chefs():
    get_db
    resp = await chefs.get_all()
    asis = await chefs.get_asistents()
    return render_template('chefs.html',chefs = resp, asistentes = asis)

#consultar patrocinadores
@app.route('/patrocinadores')
async def obtener_patrocinador():
    get_db
    resp = await patrocinadores.get_patro()
    
    return render_template('patrocinadores.html',patrocinadores = resp)


#consultar las recetas
@app.route('/recetas')
async def obtener_receta():
    get_db
    resp = await recetas.get_rece()
    return render_template('recetas.html',recetas = resp)

#consultar los ingredientes
@app.route('/ingredientes')
async def obtener_ingre():
    get_db
    resp = await ingredientes.get_ing()
    return render_template('ingredientes.html',ingredientes = resp)

#---------------------------Metodos para agregar-------------------------------------------------------------------

@app.route('/agregarAsist')
def addAsis():
    return redirect(url_for('create_Asis'))

@app.route('/addReceta', methods=['GET', 'POST'])
def addReceta():
    if request.method == 'POST':
        nombre_receta = request.form['nombre_receta']
        descripcion = request.form['descripcion']
        
        # Call the createReceta method with the form data
        result = CrudModel.createReceta(nombre_receta, descripcion)
        
        if isinstance(result, dict):  # If the result contains an error
            return render_template('error.html')  
        else:
            return render_template('exito.html') 
        
    return render_template('create_receta.html')



@app.route('/agregarChef')
def addChef():
    return redirect(url_for('create_chef'))

@app.route('/create_ingre', methods=['GET', 'POST'])
def create_ingre():
    if request.method == 'POST':
        nombreingr = request.form['nombreingr']
        descripcion = request.form['descripcion']
        
        # Llama al método createIngredient con los datos del formulario
        result = CrudModel.createIngredient(nombreingr, descripcion)
        
        if isinstance(result, dict):  # Si el resultado contiene un error
            return render_template('exito.html')  
        else:
            return render_template('error.html') 
        
    return render_template('create_ingre.html')


#------------------------Metodos para eliminar--------------------------------------------
@app.route('/deleteAsistentes/<nt>',methods=['GET'])
async def delete_asist(nt):
    get_db
    try:
        resp = asistentes.delete_all(nt)
        return resp
    except Exception as error:
        return error



@app.route('/deletePatrocinio/<nt>',methods=['GET'])
async def delete_patrocinador(nt):
    get_db
    try:
        resp = asistentes.delete_patro(nt)
        return resp
    except Exception as error:
        return error



@app.route('/deleteChefs/<nt>',methods=['GET'])
async def delete_chef(nt):
    get_db
    try:
        resp = chefs.delete_all(nt)
        return resp
    except Exception as error:
        return error

#----------------------------------------------------- Login  --------------------------------------
@app.route('/loginChef', methods=['GET', 'POST'])
async def loginCh():
    if request.method == 'POST':
        no_tarjeta = request.form.get('no_tarjeta')
        clave_acces = request.form.get('clave_acces')

        # Verifica si el usuario existe en la base de datos
        user = db.session.query(modelos.Chef).filter_by(no_tarjeta=no_tarjeta).first()
        clav = int(clave_acces)
        if user and user.clave_acces == clav:
            # Aquí puedes iniciar la sesión del usuario, por ejemplo, estableciendo una variable de sesión
            return render_template('homeChef.html')
        else:
            return('Usuario o contraseña incorrectos.')
    return render_template('logParticip.html')

@app.route('/loginAsistente', methods=['GET', 'POST'])
async def loginA():
    if request.method == 'POST':
        no_tarjeta = request.form.get('no_tarjeta')
        clave_acces = request.form.get('clave_acces')

        # Verifica si el usuario existe en la base de datos
        user = db.session.query(modelos.Asistente).filter_by(no_tarjeta=no_tarjeta).first()
        clav = int(clave_acces)
        if user and user.clave_acces == clav:
            # Aquí puedes iniciar la sesión del usuario, por ejemplo, estableciendo una variable de sesión
            return "Inicio de sesión exitoso"
        else:
            return('Usuario o contraseña incorrectos.')
    return render_template('logParticip.html')



@app.route('/loginOrga', methods=['GET', 'POST'])
async def loginOr():
    if request.method == 'POST':
        no_tarjeta_orga = request.form.get('no_tarjeta_orga')
        clave_acces = request.form.get('clave_acces')

        # Verifica si el usuario existe en la base de datos
        user = db.session.query(modelos.Organizador).filter_by(no_tarjeta_orga=no_tarjeta_orga).first()
        clav = int(clave_acces)
        if user and user.clave_acces == clav:
            # Aquí puedes iniciar la sesión del usuario, por ejemplo, estableciendo una variable de sesión
            return render_template('exito.html')
        else:
            return('Usuario o contraseña incorrectos.')
    return render_template('loginOrga.html')

#------------------------------------------Registrar--------------------------------------------------------------

from flask import request, render_template, redirect, url_for


@app.route('/registerChef', methods=['GET', 'POST'])
async def register():
    if request.method == 'POST':
        no_tarjeta = request.form['no_tarjeta']
        clave_acces = request.form['clave_acces']
        tarjetas_asistentes = request.form['tarjetas_asistentes']
        n_receta = request.form['n_receta']
        nombre = request.form['nombre']
        # Verifica si el usuario ya existe
        existing_user = db.session.query(modelos.Chef).get(no_tarjeta)
        if existing_user:
            return "La tarjeta ya está registrada."

        return redirect(url_for('create_chef'))
        

    return render_template('register.html')  # Asume que tienes un template llamado 'register.html'


@app.route('/create_chef', methods=['GET', 'POST'])
def create_chef():
    if request.method == 'POST':
        no_tarjeta = request.form['no_tarjeta']
        clave_acces = request.form['clave_acces']
        tarjetas_asistentes = request.form['tarjetas_asistentes']
        n_receta = request.form['n_receta']
        nombre = request.form['nombre']
        
        # Llama al método createChef con los datos del formulario
        result = CrudModel.createChef(no_tarjeta, clave_acces, tarjetas_asistentes, n_receta, nombre)
        
        if isinstance(result, dict):  # Si el resultado contiene un error
            return render_template('error.html')   # Renderiza una página de error
        else:
            return render_template('exito.html') # Renderiza una página de éxito
        
    return render_template('create_chef.html')


@app.route('/registerAsis', methods=['GET', 'POST'])
async def registerAsis():
    if request.method == 'POST':
        no_tarjeta = request.form['no_tarjeta']
        no_chef_jefe = request.form['no_chef_jefe']
        clave_acces = request.form['clave_acces']
        confirmacion_asis = request.form['confirmacion_asis']
        id_participante = request.form['id_participante']
        nombre = request.form['nombre']
        # Verifica si el usuario ya existe
        existing_user = db.session.query(modelos.Asistente).get(no_tarjeta)
        if existing_user:
            return "La tarjeta ya está registrada."

        return redirect(url_for('create_asist'))
        

    return render_template('registerAs.html')  # Asume que tienes un template llamado 'register.html'


@app.route('/create_asist', methods=['GET', 'POST'])
def create_Asis():
    if request.method == 'POST':
        no_tarjeta = request.form['no_tarjeta']
        no_chef_jefe = request.form['no_chef_jefe']
        clave_acces = request.form['clave_acces']
        confirmacion_asis = request.form['confirmacion_asis']
        id_participante = request.form['id_participante']
        nombre = request.form['nombre']
      
        # Llama al método createChef con los datos del formulario
        result = CrudModel.createAsist(no_tarjeta,no_chef_jefe,clave_acces,confirmacion_asis,id_participante,nombre)
        
        if isinstance(result, dict):  # Si el resultado contiene un error
            print(dict)
            return render_template('error.html')   # Renderiza una página de error
        else:
            return render_template('exito.html') # Renderiza una página de éxito
        
    return render_template('create_asist.html')


#------------------------------------------------------------------------------------------

@app.route('/update_Chef/<num>/<tarj_as>/<nomb>/<n_recet>')
def updatear_nombre_chef(num,tarj_as,nomb,n_recet):

    chef = db.session.query(modelos.Chef).filter_by(no_tarjeta=num).one_or_none()
    if chef:
        if nomb:
            chef.nombre = nomb
            db.session.commit()
        if tarj_as:
            chef.tarjetas_asistentes = tarj_as
            db.session.commit()
        if n_recet:
            chef.n_receta = n_recet
            db.session.commit()
    else:
        return jsonify([{'tarjrta incorrecta verifiquela ': chef.no_tarjeta}])

    #devuelve un JSON confirmando el cambio
    return jsonify([{'completado, nuevo nombre': chef.nombre,'tarjeta de asistente': chef.tarjetas_asistentes,'receta': chef.n_receta ,'de la tarjeta': chef.no_tarjeta}])


@app.route('/update_asistente/<num>/<tarj_chef>/<nomb>/<conf_as>', methods=['POST'])
def updatear_nombre_asis(num, tarj_chef, nomb, conf_as):
    # Conexión a la base de datos PostgreSQL
    conn = psycopg2.connect(**app.config)
    cur = conn.cursor()
    
    try:
        # Consulta para obtener el registro existente
        query_get = "SELECT * FROM asistente WHERE no_tarjeta = %s;"
        cur.execute(query_get, (num,))
        result = cur.fetchone()
        
        if result:
            # Actualiza el nombre si se proporcionó
            if nomb:
                query_update_name = "UPDATE asistente SET nombre = %s WHERE no_tarjeta = %s;"
                cur.execute(query_update_name, (nomb, num))
            
            # Actualiza la confirmación de asistencia si se proporcionó
            if conf_as:
                query_update_conf = "UPDATE asistente SET confirmacion_asis = %s WHERE no_tarjeta = %s;"
                cur.execute(query_update_conf, (conf_as, num))
            
            # Actualiza la tarjeta del chef si se proporcionó
            if tarj_chef:
                query_update_chef = "UPDATE asistente SET no_chef_jefe = %s WHERE no_tarjeta = %s;"
                cur.execute(query_update_chef, (tarj_chef, num))
            
            # Confirma los cambios en la base de datos
            conn.commit()
        else:
            return jsonify([{'error': 'Tarjeta incorrecta, verifíquela'}]), 404
        
        # Devuelve un JSON confirmando el cambio
        return jsonify([{
            'completado, nuevo nombre': result[1],
            'tarjeta de jefe': result[3],
            'asistencia': result[4]
        }])
    except Exception as e:
        print(e)
        return jsonify({'error': 'Ocurrió un error al procesar la solicitud'}), 500
    finally:
        # Cierra la conexión a la base de datos
        cur.close()
        conn.close()


@app.route('/bd')
def abrirbd():
    get_db
    return "Base de datos abierta"  # regresar

if __name__ == '__main__':
        #app.config.from_object(config.config['development'])

        app.run(debug=True, port=8881)  # se encarga de ejecutar el servidor
