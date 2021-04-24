const API_ENDPOINT = "https://pngme.azurewebsites.net";
const WSS_ENDPOINT = "wss://pngme.azurewebsites.net/sessions/join";

var socket = null;
var me = null;
var socketClosed = true;
var clients = {};

async function joinHandler() {
  const name = document.getElementById("join-name").value;
  if (name === "") {
    alert("Please supply a name");
    return;
  }
  document.getElementById("register").classList.add("hidden");
  document.getElementById("joining").classList.remove("hidden");
  await new Promise((resolve) => setTimeout(resolve, 1000));
  me = { client_id: createUUID(), name: name, client_type: "pinger" };
  socket = new WebSocket(`${WSS_ENDPOINT}/${me.client_id}?name=${me.name}`);
  socket.onopen = function (_) {
    socketClosed = false;
  };
  socket.onclose = function (_) {
    socketClosed = true;
  };
  socket.onmessage = function (event) {
    var msg = null;
    try {
      msg = JSON.parse(event.data);
    } catch {
      console.error("Invalid json from websocket.");
      return;
    }
    handleMessage(msg);
  };

  fetch(`${API_ENDPOINT}/sessions/`)
    .then(function (response) {
      return response.json();
    })
    .then(function (data) {
      console.log(data);
      // data :: List[UserView]
      for (var i = 0; i < data.length; i++) {
        addClientView(data[i]);
      }
    })
    .catch(function (reason) {
      console.log(reason);
    });
  document.getElementsByClassName("register-box")[0].classList.add("hidden");
  document.getElementById("main").classList.remove("hidden");
}

function sendPing(user) {
  if (socketClosed) {
    console.log("Can not ping right now.");
    return;
  }
  console.log(`Sending ping to ${user.name}`);
  msg = {
    mtype: "PING",
    sender: me.client_id,
    recipient: user.client_id,
  };
  socket.send(JSON.stringify(msg));
}

function handleMessage(msg) {
  switch (msg.mtype) {
    case "JOIN":
      if (msg.user.client_id == me.client_id) return;
      console.log(`${msg.user.name} joined.`);
      addClientView(msg.user);
      break;
    case "LEAVE":
      if (msg.user.client_id == me.client_id) return;
      console.log(`${msg.user.name} left.`);
      rmClientView(msg.user);
      break;
    case "PING":
      if (msg.sender == me.client_id) return;
      if (msg.recipient == me.client_id) {
        const client_name = clients[msg.sender].name;
        console.log(client_name);
        alert(`${client_name} wants to know if you're available.`);
      }
      break;
    case "PONG":
      if (msg.sender == me.client_id) return;
      handlePong(msg);
      break;
    default:
      console.log("Unknown event:", msg);
  }
}

function handlePong(msg) {
  if (msg.recipient === me.client_id) {
    console.log(`Client ${msg.sender} reacted with ${msg.status}`);
  } else {
    console.log(`Client ${msg.sender} ponged`);
  }
}

function addClientView(client) {
  if (!document.getElementById(client.client_id)) {
    if (client.client_id === me.client_id) return;
    if (!clients[client.client_id]) {
      clients[client.client_id] = client;
    }
    elem = document.createElement("div");
    elem.classList.add("user-card");
    elem.setAttribute("id", client.client_id);
    elem.innerHTML = `
    <div class="card-media">
    </div>
    <div class="card-title">
        <h3>${client.name}</h3>
    </div>
    <div class="card-actions">
        <button id='btn-${client.client_id}'>Ping</button>
    </div>
    `;
    container = document.getElementsByClassName("users")[0];
    container.appendChild(elem);
    document.getElementById(`btn-${client.client_id}`).onclick = () => sendPing(client);
  }
}

function rmClientView(client) {
  if (document.getElementById(client.client_id)) {
    elem = document.getElementById(client.client_id);
    elem.parentNode.removeChild(elem);
  } else {
    console.error(`Client ${client.client_id} not found in document`);
  }
}

// https://gist.github.com/jsmithdev/1f31f9f3912d40f6b60bdc7e8098ee9f
function createUUID() {
  let dt = new Date().getTime();

  const uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(
    /[xy]/g,
    function (c) {
      const r = (dt + Math.random() * 16) % 16 | 0;
      dt = Math.floor(dt / 16);
      return (c == "x" ? r : (r & 0x3) | 0x8).toString(16);
    }
  );

  return uuid;
}
