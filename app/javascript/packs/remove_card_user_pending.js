const buttons = document.querySelectorAll(".card-user-tmate a");
buttons.forEach((button) => {
  button.addEventListener("click", (event) => {
    const target = event.currentTarget.closest(".card-user-tmate");
    const parent = target.parentNode;
    parent.removeChild(target);
    if (document.querySelectorAll(".card-user-tmate").length === 0) {
      const h4 = document.createElement("h4")
      const text = document.createTextNode("You have no pending teammate invitation");
      h4.appendChild(text);
      h4.classList.add("empty-message");
      parent.insertBefore(h4, parent.querySelector("div.footer-size"));
    }
  });
});
