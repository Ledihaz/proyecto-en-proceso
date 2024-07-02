import passlib.context
from models import modelos

pwd_context = passlib.context.CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_user(username):
    # Aquí deberías buscar al usuario en tu base de datos
    # Por simplicidad, este ejemplo asume que el usuario existe
    return modelos.User(username=username, password_hash=pwd_context.hash("password"))

# Ejemplo de uso
user = get_user('username')
if verify_password('password', user.password_hash):
    print("Inicio de sesión exitoso")
else:
    print("Error de autenticación")
