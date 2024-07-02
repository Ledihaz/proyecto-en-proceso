from flask import Flask
import psycopg2
from typing import List

from flask import Flask
import psycopg2

app = Flask(__name__)

class CrudModel:
    def __init__(self, table_name: str):
        self.table_name = table_name
        self.columns = []
        
    async def get_columns(self):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
            
            # Consulta para obtener los nombres de las columnas
            cur.execute(f"""
                SELECT *
                FROM public.{self.table_name}
            """)
            
            rows = cur.fetchall()
            
            for row in rows:
                self.columns.append(row[0])
            
            return self.columns  # Return the list of columns

        except Exception as error:
            return(f"Error: {error}")
        finally:
            if conn is not None:
                conn.close()

    async def get_all(self):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
            
            # Consulta para obtener todos los registros de la tabla
            cur.execute(f"""
                SELECT nombre,no_tarjeta FROM public."{self.table_name}"
            """)
            
            rows = cur.fetchall()
            
            return rows  # Return the rows

        except Exception as error:
            return(f"Error: {error}")
        finally:
            if conn is not None:
                conn.close()
    

    async def get_asistents(self):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
            
            # Consulta para obtener todos los registros de la tabla
            cur.execute(f"""
                SELECT tarjetas_asistentes FROM public."{self.table_name}"
            """)
            
            rows = cur.fetchall()
            
            return rows  # Return the rows

        except Exception as error:
            return(f"Error: {error}")
        finally:
            if conn is not None:
                conn.close()


    
    


    async def get_patro(self):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
            
            # Consulta para obtener todos los registros de la tabla
            cur.execute(f"""
                SELECT nombre,ido FROM public."{self.table_name}"
            """)
            
            rows = cur.fetchall()
            
            return rows  # Return the rows

        except Exception as error:
            return(f"Error: {error}")
        finally:
            if conn is not None:
                conn.close()

    
    async def get_rece(self):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
            
            # Consulta para obtener todos los registros de la tabla
            cur.execute(f"""
                SELECT nombre_receta,descripcion FROM public."{self.table_name}"
            """)
            
            rows = cur.fetchall()
            
            return rows  # Return the rows

        except Exception as error:
            return(f"Error: {error}")
        finally:
            if conn is not None:
                conn.close()


    async def get_ing(self):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
            
            # Consulta para obtener todos los registros de la tabla
            cur.execute(f"""
                SELECT nombreingr,descripcion FROM public."{self.table_name}"
            """)
            
            rows = cur.fetchall()
            
            return rows  # Return the rows

        except Exception as error:
            return(f"Error: {error}")
        finally:
            if conn is not None:
                conn.close()
#---------------------------------------Metodos Delete--------------------------------------------------------------
    def delete_all(self, tarj):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
        
            # Consulta para eliminar los registros de la tabla
            cur.execute(f"""
            DELETE FROM public."{self.table_name}" WHERE no_tarjeta = %s
            """, (tarj,))
        
            # Confirmar los cambios
            conn.commit()
        
            # Obtener el número de filas eliminadas
            rows_deleted = cur.rowcount
        
            return {'rows_deleted': rows_deleted}

        except Exception as error:
            # Rollback en caso de error
            if conn is not None:
                conn.rollback()
            return {'error': f"Error al eliminar: {error}"}
        finally:
            if conn is not None:
                conn.close()


    def delete_patro(self, tarj):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
        
            # Consulta para eliminar los registros de la tabla
            cur.execute(f"""
            DELETE FROM public."{self.table_name}" WHERE ido = %s
            """, (tarj,))
        
            # Confirmar los cambios
            conn.commit()
        
            # Obtener el número de filas eliminadas
            rows_deleted = cur.rowcount
        
            return {'rows_deleted': rows_deleted}

        except Exception as error:
            # Rollback en caso de error
            if conn is not None:
                conn.rollback()
            return {'error': f"Error al eliminar: {error}"}
        finally:
            if conn is not None:
                conn.close()

#--------------------------------------------------------------crear nuevos usuarios---------------------------------

    def createChef(no_tarjeta,clave_acces,tarjetas_asistentes,n_receta,nombre):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
        
            query = """
                INSERT INTO chef (no_tarjeta, clave_acces,tarjetas_asistentes,n_receta,nombre)
                VALUES (%s, %s, %s, %s, %s);
                """
            
                        
            cur.execute(query, (no_tarjeta, clave_acces,tarjetas_asistentes,n_receta,nombre))

            # Confirmar los cambios
            conn.commit()
        
            return "Usuario Registrado"
            
                    
            
        except Exception as error:
            # Rollback en caso de error
            if conn is not None:
                conn.rollback()
            return {'error': f"Error : {error}"}
        finally:
            if conn is not None:
                conn.close()
                cur.close()
        

    def createReceta(nombre_receta,descripcion):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
        
            query = """
                INSERT INTO receta (nombre_receta,descripcion)
                VALUES (%s, %s);
                """
            
                        
            cur.execute(query, (nombre_receta,descripcion))

            # Confirmar los cambios
            conn.commit()
        
            return "Receta Registrada"
            
                    
            
        except Exception as error:
            # Rollback en caso de error
            if conn is not None:
                conn.rollback()
            return {'error': f"Error : {error}"}
        finally:
            if conn is not None:
                conn.close()
                cur.close()


    def createIngredient(nombreingr,descripcion):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
        
            query = """
                INSERT INTO ingredientes (nombreingr,descripcion)
                VALUES (%s, %s);
                """
            
                        
            cur.execute(query, (nombreingr,descripcion))

            # Confirmar los cambios
            conn.commit()
        
            return "Ingrediente Registrado"
            
                    
            
        except Exception as error:
            # Rollback en caso de error
            if conn is not None:
                conn.rollback()
            return {'error': f"Error : {error}"}
        finally:
            if conn is not None:
                conn.close()
                cur.close()


    def createAsist(no_tarjeta,no_chef_jefe,clave_acces,confirmacion_asis,id_participante,nombre):
        conn = None
        try:
            # Conexión a la base de datos
            conn = psycopg2.connect(
                host="localhost",
                database="postgres",
                user="postgres",
                password="1234"
            )
            cur = conn.cursor()
        
            query = """
                INSERT INTO asistente (no_tarjeta,no_chef_jefe,clave_acces,confirmacion_asis,id_participante,nombre)
                VALUES (%s, %s, %s, %s, %s, %s);
                """
            
                        
            cur.execute(query, (no_tarjeta,no_chef_jefe,clave_acces,confirmacion_asis,id_participante,nombre))

            # Confirmar los cambios
            conn.commit()
        
            return "Usuario Registrado"
            
                    
            
        except Exception as error:
            # Rollback en caso de error
            if conn is not None:
                conn.rollback()
            print(error)
            return {'error': f"Error : {error}"}
        finally:
            if conn is not None:
                conn.close()
                cur.close()
        





if __name__ == '__main__':
    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:1234@localhost:5432/postgres'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    
    app.run(debug=True, port=8881)  # se encarga de ejecutar el servidor
