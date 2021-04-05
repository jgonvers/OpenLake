
const divDisplay = document.querySelector('#weather-fc');
const a = document.getElementById('mycontainer').dataset.address; // address
const b = a.split(" ")[a.split(" ").length - 1]; // last word of address



const requestAPI = (cityValue, dateevent) => {
  fetch(`https://api.openweathermap.org/data/2.5/weather?q=${cityValue},${dateevent}&appid=b36426291fcbb98ff7c07c74bc4b7990`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      console.log(divDisplay);
      const temperature = Math.round((data.main.temp - 273.15) * 100) / 100;
      const feel_temp = Math.round((data.main.feels_like - 273.15) * 100) / 100;
      const cloud = data.weather[0].description;
      console.log(cloud);
      console.log(temperature); // Get the temp for the city
      icon_weather = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`; // please let this line even if unuseful
      console.log(icon_weather)
      divDisplay.insertAdjacentHTML("beforeend", `<img src="https://openweathermap.org/img/w/${data.weather[0].icon}.png" style="height: 30px; width: 30px;"> `);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 14px; color: #8c8a8a">&nbsp${cloud.capitalize()} -&nbsp</p>`);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 14px; color: #8c8a8a">${temperature}°C -&nbsp</p>`);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 14px; color: #8c8a8a">Humidity: ${data.main.humidity}%</p>`);
    });
};

requestAPI(b, document.getElementById('mycontainer').dataset.start_time)
// console.log(requestAPI(`${('#mycontainer').data('address')}`, "Tue, 30 Mar 2021 13:31:15 UTC +00:00"));

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
};
