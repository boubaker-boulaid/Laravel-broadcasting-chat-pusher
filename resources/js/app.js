import "./bootstrap";
window.Echo.channel("chat").listen("MessageSentEvent", (e) => {
    console.log('message recieved :', e);
    let div = document.getElementById("messages");
    div.innerHTML += `<p>${e.message}</p>`;
});