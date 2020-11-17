document.addEventListener('DOMContentLoaded', () => {
  function logClick() {
    window.onclick = (event) => {
      console.log('Click', event);
      const path = flattenPath(event.path);
      const requestData = {
        id: getIDFromURL(),
        time: new Date().toISOString(),
        location: document.location.href,
        click: `${path}/${elementText(event)}`
      }
      post(LOGGER_URL, JSON.stringify(requestData))
    }
  }
  logClick();

  function flattenPath(list) {
    list.reverse()
    let s = '';
    for (let i = 0; i < list.length; i++) {
      const element = list[i];
      if (element.localName) {
        const cn = element.className == '' ? '' : `.${element.className}`;
        s += `/${element.localName}${cn}`;
      }
    }
    return s;
  }

  function elementText(element) {
    if (element.srcElement.textContent) {
      return element.srcElement.textContent.replace(/^\s+|\s+$/g, '')
    }
    return ""
  }
});
