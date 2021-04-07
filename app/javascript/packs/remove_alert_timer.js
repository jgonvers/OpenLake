function removeAlert() {
  const alerts = document.querySelectorAll("div.alert");
  if (alerts !== null) {
    alerts.forEach((alert) => { alert.parentNode.removeChild(alert); });
  }
}


setTimeout(removeAlert, 2500)