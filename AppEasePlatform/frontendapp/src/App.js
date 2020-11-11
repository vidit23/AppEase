import './App.css';
import { BrowserRouter, Switch, Route, NavLink } from 'react-router-dom';
import Login from './components/login';
import Dashboard from './components/dashboard';
import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return ( 
    <div className = "App" >
      <BrowserRouter>
        <div>
          <div className="content">
            <Switch>
              <Route exact path="/" component={Login} />
              <Route path="/dashboard" component={Dashboard} />
            </Switch>
          </div>
        </div>
      </BrowserRouter>
    </div>
  );
}

export default App;