from fastapi import FastAPI
import random
import string
import uvicorn

from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

@app.get("/")
async def root():
    # Generate 8 random characters
    random_chars = ''.join(random.choices(string.ascii_letters + string.digits, k=8))
    return {"message": f"online_{random_chars}"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5000)