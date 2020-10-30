async function post(url, data, accept = 'application/json', contentType = 'application/json') {
  return fetch(url, {
    method: "POST",
    body: data,
    headers: {
      'Accept': accept,
      'Content-Type': contentType
    }
  })
};

async function get(url) {
  return fetch(url, {
    method: "GET",
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
}
