const divs = document.querySelectorAll(".button-teammate");
const parents = [...divs].map(div => div.parentElement);
const buttons = parents.filter(parent => parent.nodeName === "A");
buttons.forEach((button) => {
  button.addEventListener("click", (event) => {
    // but enlever le lien, changer la class pour le pending
    const target = event.currentTarget;
    const parent = target.parentElement;
    target.parentNode.removeChild(target); //remove link and button
    const div = document.createElement("div");
    const i = document.createElement("i");
    const p = document.createElement("p");
    const text = document.createTextNode("Requested");
    p.appendChild(text);
    i.classList.add("far", "fa-hourglass", "mr-2");
    div.appendChild(i);
    div.appendChild(p);
    div.classList.add("button-teammate", "d-flex", "flex-row", "justify-content-center", "align-items-center", "fist");
    parent.appendChild(div);// cree le div du boutton sans le lien et le mets en place
  });
});
