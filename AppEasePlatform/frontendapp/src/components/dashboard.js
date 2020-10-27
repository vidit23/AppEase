import React, { Component } from 'react';
import { Redirect } from "react-router-dom";
import { getUser, removeUserSession, getToken } from '../utils/common';

class Dashboard extends Component {
    user = getUser();
    state = {
        redirect: false
    }
  // handle click event of logout button
    handleLogout = () => {
        var token = getToken();
        fetch('http://127.0.0.1:8000/api/logout/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(token)
        })
        .then(response => response.json())
        .then(
            data => {
                console.log(data);
                removeUserSession();
                this.setState({
                    redirect: true
                })
            }
        ).catch(error => console.error(error))
    }
    render () {
        if (this.state.redirect) {
            return <Redirect to='/' />
        }
        return (
            <div>
                Welcome {this.user.name}!<br /><br />
                <button onClick = { this.handleLogout } > Log Out </button>
            </div>
        );
    }
}
 
export default Dashboard;