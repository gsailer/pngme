const API_ENDPOINT = 'https://pngme.azurewebsites.net';
const WSS_ENDPOINT = 'wss://pngme.azurewebsites.net/sessions/join'

var socket = null

function joinHandler() {
  document.getElementById('register').classList.add('hidden');
  document.getElementById('joining').classList.remove('hidden');

  const name = document.getElementById('join-name').value;
  // TODO: check if name === ""

  socket = new WebSocket(`${WSS_ENDPOINT}/${createUUID()}?name=${name}`);
  socket.onmessage = function (event) {
    const msg = JSON.parse(event.data);
    handleMessage(msg);
  }
  
  fetch(`${API_ENDPOINT}/sessions/`).then(function (response) {
    return response.json();
  }).then(function (data) {
    console.log(data);
  }).catch(function (reason) {
    console.log(reason);
  });
  document.getElementsByClassName('register-box')[0].classList.add('hidden');
}

function handleMessage(msg) {
  switch(msg.mtype) {
    case "JOIN":
      console.log(`${msg.user.name} joined.`);
      break;
    case "LEAVE":
      console.log(`${msg.user.name} left.`);
      break;
    default:
      console.log("Unknown event:", msg);
  }
}

// https://gist.github.com/jsmithdev/1f31f9f3912d40f6b60bdc7e8098ee9f
function createUUID(){
   
  let dt = new Date().getTime()
  
  const uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      const r = (dt + Math.random()*16)%16 | 0
      dt = Math.floor(dt/16)
      return (c=='x' ? r :(r&0x3|0x8)).toString(16)
  })
  
  return uuid
}