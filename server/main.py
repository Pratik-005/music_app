import bcrypt
from fastapi import FastAPI, HTTPException
from server.models.base import Base
from server.routes import auth
from server.db.db import engine


Base.metadata.create_all(engine)
app = FastAPI()
app.include_router(auth.router,prefix='/auth')
