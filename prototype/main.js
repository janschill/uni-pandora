document.addEventListener('DOMContentLoaded', () => {
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
        get('http://localhost:8080/id')
          .then(response => response.json())
          .then(data => {
            const requestData = {
              id: data.id,
              time: new Date().toISOString(),
              path: path
            }
            post('http://localhost:8080/logger', JSON.stringify(requestData))
              .then(() => {
                window.location.href = `${path}?id=${requestData.id}`
              });
          })
      };
      anchor.appendChild(text);
      li.appendChild(anchor);
      pandoraWebsiteList.appendChild(li);
    }
  }

  const pathToPandoraWebsites = [
    'sustainable/index.html',
    'regular/index.html'
  ];
  createAnchors(pathToPandoraWebsites);
});
