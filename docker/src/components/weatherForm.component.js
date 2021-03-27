import {Component} from 'react';
import * as React from 'react';
import SimpleMap from './SimpleMap.component';
export default class weatherForm extends Component {

    constructor(props) {
        super(props);
        
        this.state = {
            city: '',
            center: {
                lat: -33.865143,
                lng: 151.209900,
            },            
            weather: '',
            country: ''
        };
    }
    
    

    onChangeCity = (e) => {
        this.setState({
            city: e.target.value,
            weather: ''
        });
    }

    onSubmit = (e) =>{
        e.preventDefault();
        let apiKey = 'ee408b842f41f3263792690b39068fbc';
        fetch(`https://api.openweathermap.org/data/2.5/weather?q=`+ this.state.city+ `&units=metric&appid=`+ apiKey)
        .then(response => response.json())
        .then(weather => this.setState({
            country: weather.sys.country,
            center: {
                lat: weather.coord.lat,
                lng: weather.coord.lon,
            },
            weather: weather.main.temp}))
        .catch(function(error){
            console.log(error);
        });
        
    
    }


    render() {
        let result = '';
        if (this.state.weather!=='') {
            result = 'Temperature in '+ this.state.city + ', '+ this.state.country +'  is ' + this.state.weather + ' Celsius';     
        }else{
            result = '';
        }
        return (
            <>
                <h3>Weather Form</h3>
                <form onSubmit={this.onSubmit}>
                    <input name="city" type="text" value={this.state.city} 
                            className="ghost-input" 
                            onChange={this.onChangeCity}
                            placeholder="Enter a City" required />
                    <input type="submit" className="ghost-button" value="Get Weather" />
                </form>
                <div>
                    <br /><br /><br />
                </div>
                <div className="container">
                    {result}
                </div>
                <div>
                    <br /><br />
                </div>
                <div>
                   <SimpleMap center={this.state.center}></SimpleMap>     
                </div>
            </>
        )
    }
}
