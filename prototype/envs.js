const LOGGER_URL = 'http://localhost:8080/logger';
const ID_URL = 'http://localhost:8080/id';

function getIDFromURL() {
  const urlParams = new URLSearchParams(window.location.search);
  const id = urlParams.get('id');
  return parseInt(id);
}
