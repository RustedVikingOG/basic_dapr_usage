from fastapi import FastAPI
import random
import string
import uvicorn

app = FastAPI()

@app.get("/")
async def root():
    # Generate 8 random characters
    random_chars = ''.join(random.choices(string.ascii_letters + string.digits, k=8))
    return {"message": f"online_{random_chars}"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)