document.addEventListener('DOMContentLoaded', () => {
  function preparePost() {
    window.post = function (url, data, accept = 'application/json', contentType = 'application/json') {
      return fetch(url, {
        method: "POST",
        body: data,
        headers: {
          'Accept': accept,
          'Content-Type': contentType
        }
      });
    }
  }
  preparePost();

  function createAnchors(pathToPandoraWebsites) {

    for (let i = 0; i < pathToPandoraWebsites.length; i++) {
      const pandoraWebsiteList = document.querySelector('#pandora-website-list');
      const path = pathToPandoraWebsites[i];
      const li = document.createElement("li");
      const anchor = document.createElement("A");
      const text = document.createTextNode(path.split('/')[0]);
      anchor.setAttribute('href', path)
      anchor.onclick = (event) => {
        event.preventDefault();
        const data = {
          id: 'randomId',
          time: new Date().toISOString(),
          path: path
        }
        post('http://localhost:8080/logger', JSON.stringify(data));
      };
      anchor.appendChild(text);

      li.appendChild(anchor);
      pandoraWebsiteList.appendChild(li);
    }
  }

  function randomizeOneAnchor() {
    const randomPandoraAnchor = document.querySelector('#random-pandora-anchor');
    randomPandoraAnchor.addEventListener('click', () => {
      const randomIndex = Math.floor(Math.random() * pathToPandoraWebsites.length)
      randomPandoraAnchor.setAttribute('href', pathToPandoraWebsites[randomIndex])
    });
  }

  const pathToPandoraWebsites = [
    'sustainable/index.html',
    'regular/index.html'
  ];
  createAnchors(pathToPandoraWebsites);
  // randomizeOneAnchor(pathToPandoraWebsites);
});
