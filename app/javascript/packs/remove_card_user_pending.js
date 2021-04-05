const buttons = document.querySelectorAll(".card-user-tmate a");
buttons.forEach((button) => {
  button.addEventListener("click", (event) => {
    const target = event.currentTarget.closest(".card-user-tmate");
    target.parentNode.removeChild(target);
  });
});