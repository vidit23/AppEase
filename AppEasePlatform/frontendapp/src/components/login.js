import React, { Component } from 'react';
import { Redirect } from "react-router-dom";
import { setUserSession } from '../utils/common';

class Login extends Component {
    state = {
        credentials: {
            username: '',
            password: ''
        },
        register: false,
        redirect: false
    }
    login = event => {
        fetch('http://127.0.0.1:8000/api/login/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(this.state.credentials)
        })
        .then(response => response.json())
        .then(
            data => {
                console.log(data);
                setUserSession(data.token, this.state.credentials.username);
                this.setState({
                    redirect: true
                })
            }
        ).catch(error => console.error(error))
    }
    register = event => {
        fetch('http://127.0.0.1:8000/api/register/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(this.state.credentials)
        })
        .then(response => response.json())
        .then(
            data => {
                console.log(data);
                // setUserSession(data.token, data.user.username);
                this.setState({
                    redirect: true
                })
            }
        ).catch(error => console.error(error))
    }
    registerstate = event => {
        this.setState(prevState => 
            ({ register: !prevState.register })
        )
    }
    inputChanged = event => {
        const credentials = this.state.credentials;
        console.log(credentials)
        credentials[event.target.name] = event.target.value;
        this.setState({ credentials: credentials })
    }
    render() {
        if (this.state.redirect) {
            return <Redirect to='/dashboard' />
        }
        return ( 
            <div className = "App" >
                <h1> Login User </h1> 
                {this.state.register && <label> Email:
                    <input type = 'email'
                        name = 'email'
                        value = { this.state.credentials.email }
                        onChange = { this.inputChanged }
                    /> 
                </label>}
                <label > Username:
                    <input type = 'text'
                        name = 'username'
                        value = { this.state.credentials.username }
                        onChange = { this.inputChanged }
                    />     
                </label>
                <br/>
                <label> Password:
                    <input type = 'password'
                        name = 'password'
                        value = { this.state.credentials.password }
                        onChange = { this.inputChanged }
                    /> 
                </label>
                <br/>
                {!this.state.register && <button onClick = { this.login } > Login </button> }
                <a onClick = { this.registerstate } > Not a member? Click to register </a> 
                {this.state.register && <button onClick = { this.register } > Register </button> }
            </div>
        );
    }

}

export default Login;