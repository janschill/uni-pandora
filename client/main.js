document.addEventListener('DOMContentLoaded', () => {
  console.log('Content loaded');
  preparePost();
  logClick();
  // logKeyPressing();
  // logGeneralMouseMovement();
  // logObjectMouseMovement();
  // logScrollPosition();
  // captureDomAndGenerateImage();
});

function preparePost() {
  window.post = function (url, data) {
    return fetch(url, {
      method: "POST",
      body: data,
      headers: {
        'Content-Type': 'text/html'
      }
    });
  }
}

function sendDOMToServer() {
  post("http://localhost:8080/logger", document.body.outerHTML);
}

function captureDomAndGenerateImage() {
  html2canvas(document.body).then((canvas) => {
    document.body.appendChild(canvas);
  });
}

function logScrollPosition() {
  window.onscroll = (event) => {
    console.log('Scroll', document.body.clientHeight)
  }
}

function logClick() {
  window.onclick = (event) => {
    console.log('Click', event);
    event.target.classList.add('clicked');
    sendDOMToServer();
  }
}

function logObjectMouseMovement() {
  window.onmouseover = (event) => {
    console.log('Mouse over', event)
  }
}

function logGeneralMouseMovement() {
  window.onmousemove = (event) => {
    console.log(`Mouse moving: (${event.x}, ${event.y})`)
  }
}

function logKeyPressing() {
  window.onkeydown = (event) => {
    console.log(`Key pressed: ${event.keyCode}`);
  }
}
