
const divDisplay = document.querySelector('#weather-fc');


const requestAPI = (cityValue, dateevent) => {
  fetch(`https://api.openweathermap.org/data/2.5/weather?q=${cityValue},${dateevent}&appid=b36426291fcbb98ff7c07c74bc4b7990`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      console.log(divDisplay);
      const temperature = Math.round((data.main.temp - 273.15) * 100) / 100;
      const cloud = data.weather[0].description;
      console.log(temperature); // Get the temp for the city
      icon_weather = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`; // please let this line even if unuseful
      console.log(icon_weather)
      divDisplay.insertAdjacentHTML("beforeend", `<h3><strong>${temperature}°</strong></h3>`);
      divDisplay.insertAdjacentHTML("beforeend", `<img src="https://openweathermap.org/img/w/${data.weather[0].icon}.png" style="height: 30px; width: 30px;"> `);
      divDisplay.insertAdjacentHTML("beforeend", `<h3><strong>${cloud}°</strong></h3>`);

    });
};

console.log(requestAPI("lausanne", "Tue, 30 Mar 2021 13:31:15 UTC +00:00"));

