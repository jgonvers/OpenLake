
const divDisplay = document.querySelector('#weather-fc');


const requestAPI = (cityValue, dateevent) => {
  fetch(`https://api.openweathermap.org/data/2.5/weather?q=${cityValue},${dateevent}&appid=b36426291fcbb98ff7c07c74bc4b7990`)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      console.log(divDisplay);
      const temperature = Math.round((data.main.temp - 273.15) * 100) / 100;
      const feel_temp = Math.round((data.main.feels_like - 273.15) * 100) / 100;
      const cloud = data.weather[0].description;
      console.log(temperature); // Get the temp for the city
      icon_weather = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`; // please let this line even if unuseful
      console.log(icon_weather)
      divDisplay.insertAdjacentHTML("beforeend", `<img src="https://openweathermap.org/img/w/${data.weather[0].icon}.png" style="height: 20px; width: 20px;"> `);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 12px; color: #a4a4a4">${cloud},&nbsp</p>`);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 12px; color: #a4a4a4">${temperature}°C,&nbsp</p>`);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 12px; color: #a4a4a4">feels like: ${feel_temp}°C,&nbsp</p>`);
      divDisplay.insertAdjacentHTML("beforeend", `<p style="font-size: 12px; color: #a4a4a4">humidity: ${data.main.humidity}%</p>`);
    });
};

console.log(requestAPI("lausanne", "Tue, 30 Mar 2021 13:31:15 UTC +00:00"));

