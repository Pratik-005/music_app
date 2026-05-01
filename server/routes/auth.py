import uuid

import bcrypt
from fastapi import Depends, HTTPException

from server.db.db import get_db
from server.models.user import User
from server.pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter
from sqlalchemy.orm import Session

router  = APIRouter()

@router.post('/signup')
def signup_user(user : UserCreate , db : Session= Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    
    if user_db :
        raise HTTPException(400,'user already exists !')

    hashed_password = bcrypt.hashpw(user.password.encode() , bcrypt.gensalt(10))

    user_db = User(id= str( uuid.uuid4()),email = user.email , name=  user.name , password = hashed_password )
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db