import asyncio
import os

from fastapi import FastAPI, WebSocket

from app.endpoints import health, sessions


app = FastAPI()


app.include_router(health.router)
app.include_router(sessions.router, prefix="/sessions", tags=["sessions"])
