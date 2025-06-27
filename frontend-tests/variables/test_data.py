import time

def get_user_credentials(user_type="valid"):
    timestamp = int(time.time())
    if user_type == "valid":
        return {
            "name": "Usuario Teste",
            "email": f"usuario{timestamp}@teste.com",
            "password": "senha123"
        }
    elif user_type == "invalid":
        return {
            "email": "usuario@errado.com",
            "password": "senha_incorreta"
        }
    return {}