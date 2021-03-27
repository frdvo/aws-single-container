import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';


const Marker = props => {
  return <div className="pin"></div>
}
 
class SimpleMap extends Component {
  
  static defaultProps = {
    centerDefault: {
      lat: '',
      lng: ''
    },
    zoom: 12
  };

  

  constructor(props) {
    super(props);
    
    this.state = {
      center: {
        lat: this.props.lat,
        lng: this.props.lng
      },
      zoom: 12
    };
  }

  

  render() {
    
    return (
      <div style={{ height: '50vh', width: '50%' }}>
        <GoogleMapReact
          bootstrapURLKeys={{ key:"AIzaSyD1jLsqcF3_qU89ow-Jm1la8Zt6nF5mTUQ" }}
          center={this.props.center}
          defaultZoom={this.props.zoom}
          marker={this.props.center}
        >
        <Marker lat={this.props.center.lat} lng={this.props.center.lng} />
        </GoogleMapReact>
      </div>
    );
  }
}

export default SimpleMap;