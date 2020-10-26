import React, { Component } from 'react';

class Login extends Component {
    state = {
        credentials: {
            username: '',
            password: ''
        }
    }
    login = event => {
        console.log(this.state.credentials);
        fetch('http://127.0.0.1:8000/api/login/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(this.state.credentials)
        }).then(
            data => {
                console.log(data);
            }
        ).catch(error => console.error(error))
    }
    inputChanged = event => {
        const credentials = this.state.credentials;
        credentials[event.target.name] = event.target.value;
        this.setState({ credentials: credentials })
    }
    render() {
        return ( 
            <div className = "App" >
                <h1> Login User </h1> 
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
                <button onClick = { this.login } > Login </button> 
                <a>Register Now</a>
            </div>
        );
    }

}

export default Login;