import React, { Component } from 'react';
import {BrowserRouter, Route, Switch} from "react-router-dom";
import './App.css';
import Login from './components/Login';
import weatherForm from './components/weatherForm.component';

class App extends Component {

  

  render() {
    return (
      <BrowserRouter>
        <Switch>
            <Route path="/" exact component={weatherForm} />

            <Route pth="/login" >
              <Login />
            </Route>
            
        </Switch>
      </BrowserRouter>
    );
  }
}

export default App;
