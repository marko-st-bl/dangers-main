/**
 * 
 */
let countries;
let lon;
let lat;

function loadForecast(country) {
		let xhr = new XMLHttpRequest();
		xhr.open('GET', 'https://restcountries.eu/rest/v2/region/europe',
				'true');
		xhr.onload = function() {
			if (this.status == 200) {
				countries = JSON.parse(this.responseText);
				let output = '';
				for ( let i in countries) {
					if (countries[i].name == country) {
						lat = countries[i].latlng[0];
						lon = countries[i].latlng[1];
						console.log(lat + " " + lon);

						xhr1 = new XMLHttpRequest();
						url = 'http://api.openweathermap.org/data/2.5/find?lat='
								+ lat
								+ '&lon='
								+ lon
								+ '&cnt=30&units=metric&&APPID=529b81310379224f19501c0caf39800b';
						xhr1.open('GET', url, 'true');
						xhr1.onload = function() {
							if (this.status == 200) {
								let forecasts = JSON.parse(this.responseText);
								console.log(forecasts);
								let forecast1 = Math.floor(Math.random() * 30);
								let forecast2 = Math.floor(Math.random() * 30);
								let forecast3 = Math.floor(Math.random() * 30);
								document.getElementById('cityName1').innerHTML = forecasts.list[forecast1].name;
								document.getElementById('icon1').src = 'http://openweathermap.org/img/wn/'
										+ forecasts.list[forecast1].weather[0].icon
										+ '@2x.png';
								document.getElementById('temp1').innerHTML = Math
										.round(forecasts.list[forecast3].main.temp)
										+ '&#8451;';
								document.getElementById('cityName2').innerHTML = forecasts.list[forecast2].name;
								document.getElementById('icon2').src = 'http://openweathermap.org/img/wn/'
										+ forecasts.list[forecast2].weather[0].icon
										+ '@2x.png';
								document.getElementById('temp2').innerHTML = Math
										.round(forecasts.list[forecast3].main.temp)
										+ '&#8451;';
								document.getElementById('cityName3').innerHTML = forecasts.list[forecast3].name;
								document.getElementById('icon3').src = 'http://openweathermap.org/img/wn/'
										+ forecasts.list[forecast3].weather[0].icon
										+ '@2x.png';
								document.getElementById('temp3').innerHTML = Math
										.round(forecasts.list[forecast3].main.temp)
										+ '&#8451;';
							}
						}
						xhr1.send();
					}
				}
			}
		}
		xhr.send();
	}