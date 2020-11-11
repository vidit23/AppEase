import React, { Component } from 'react';
import { Redirect } from "react-router-dom";
import { setUserSession } from '../utils/common';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
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
                <Form>
                    <Row>
                        <Col>
                            <Form.Group controlId="formBasicEmail">
                                <Form.Label>Email address</Form.Label>
                                <Form.Control type="email" placeholder="Enter email" />
                                <Form.Text className="text-muted">
                                    We'll never share your email with anyone else.
                                </Form.Text>
                            </Form.Group>
                        </Col>
                        <Col>
                            <Form.Group controlId="formBasicPassword">
                                <Form.Label>Password</Form.Label>
                                <Form.Control type="password" placeholder="Password" />
                            </Form.Group>
                        </Col>
                    </Row>
                    <Row>
                        <Col>
                            <Form.Group controlId="formBasicCheckbox">
                                <Form.Check type="checkbox" label="Check me out" />
                            </Form.Group>
                        </Col>
                        <Col>
                            <Button variant="primary" type="submit">
                                Submit
                            </Button>
                        </Col>
                    </Row>
                </Form>
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