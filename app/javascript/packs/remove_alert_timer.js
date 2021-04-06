function removeAlert() {
  const alert = document.querySelector("div.alert");
  if (alert !== null) {
    alert.parentNode.removeChild(alert);
  }
}


setTimeout(removeAlert, 3000)