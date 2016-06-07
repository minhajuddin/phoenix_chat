import {Socket} from "phoenix"

let username = localStorage.getItem("username");;

if (!username) {
  username = prompt("What should we call you?");
  localStorage.setItem("username", username);
}


// we are connecting to a websocket at path /socket
let socket = new Socket("/socket", {params: {username: username}})

socket.connect()

let messages = document.getElementById("messages");
let input = document.getElementById("input");
let room = messages.attributes['data-room'].value;

// route in your controller
let channel = socket.channel(room, {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })


input.addEventListener("keyup", function(e){
  if (e.keyCode != 13) {
    return
  }

  channel.push("msg", {body: input.value})
  input.value = "";
})


channel.on("msg", function(message){
  messages.innerHTML += `<div class=message>@${message.username} [<a href='/user/${message.username}/block?current_username=${username}'>block</a>]  ${message.body}</div>`
})

export default socket
