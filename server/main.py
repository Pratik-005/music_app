import bcrypt
from fastapi import FastAPI, HTTPException
from server.models.base import Base
from server.routes import auth,song
from server.db.db import engine
import cloudinary
import cloudinary.uploader

cloudinary.config( 
  cloud_name = "dfztvv4mu", 
  api_key = "158771665942465", 
  api_secret = "158771665942465"
)

Base.metadata.create_all(engine)
app = FastAPI()
app.include_router(auth.router,prefix='/auth')
app.include_router(song.router,prefix='/song')
