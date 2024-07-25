# install playwright, find vpn rotation tools

from fastapi import FastAPI

print("runnning main.py")

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}
