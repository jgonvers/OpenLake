const addressUser = document.querySelector('#address');
const btnSend = document.querySelector('#btnsend');
const divDisplay = document.querySelector('#display-weather');


const requestAPI = (cityValue) => {
  fetch(`https://api.openweathermap.org/data/2.5/weather?q=${cityValue}&appid=b36426291fcbb98ff7c07c74bc4b7990`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      const temperature = Math.round((data.main.temp - 273.15) * 100) / 100;
      const cloud = data.weather[0].description;
      console.log(temperature); // Get the temp for the city
      const today = new Date();
      const localOffset = data.timezone + today.getTimezoneOffset() * 60;
      const localDate = new Date(today.setUTCSeconds(localOffset));
      const options = {
        weekday: 'long', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric'
      };
      const formattedDate = localDate.toLocaleDateString("en-US", options);
      // divDisplay.insertAdjacentHTML("beforeend", `<h2>Weather in ${cityValue}</h2>`);
      // divDisplay.insertAdjacentHTML("beforeend", `<p><strong>${formattedDate}</strong></p>`);
      // divDisplay.insertAdjacentHTML("beforeend", `<p>${cloud}</p>`);
      // divDisplay.insertAdjacentHTML("beforeend", `<h4><strong>${temperature}°</strong> Celsius Degree</h4>`);
    });
};

console.log(requestAPI("lausanne"));

