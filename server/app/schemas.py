from pydantic import BaseModel, Field
from typing import Dict
from fastapi import WebSocket

class Client(BaseModel):
    socket: WebSocket
    name: str
    client_type: str

    class Config:
        arbitrary_types_allowed = True

class Session(BaseModel):
    active_connections: Dict[int, Client] = Field(...)

    async def connect(self, websocket: WebSocket, cid: int, name: str, client_type: str):
        await websocket.accept()
        self.active_connections[cid] = Client(socket=websocket, name=name, client_type=client_type)

    def disconnect(self, cid: int):
        del self.active_connections[cid]

    async def send_personal_message(self, message: str, cid: int):
        await seld.active_connections[cid].socket.send_text(message)

    async def broadcast(self, message: str):
        for client in self.active_connections.values():
            await client.socket.send_text(message)

    class Config:
        arbitrary_types_allowed = True

class UserView(BaseModel):
    client_id: str
    name: str
    client_type: str


class Message(BaseModel):
    mtype: str = Field(...)

class Join(Message):
    mtype : str = "JOIN"
    user : UserView = Field(...)

class Leave(Message):
    mtype : str = "LEAVE"
    user : UserView = Field(...)
