from fastapi import FastAPI

app = FastAPI(title="API Enciclopedia Digial do Rock", version="1.0.0")

@app.get("/")
def read_root():
    return {"mensagem": "API da faculdade está rodando com FastAPI e Poetry!"}
