const button = document.querySelector("#btn-filter")

button.addEventListener("click", (event) => {
  document.querySelector("div.search").classList.toggle("hidden")
  event.currentTarget.classList.toggle("hidden")
});