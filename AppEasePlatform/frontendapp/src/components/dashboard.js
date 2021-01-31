import React, { Component } from 'react';
import { Redirect } from "react-router-dom";
import { getToken, getUser } from '../utils/common';
import { TimeSeries, Index } from "pondjs";
import {
  Charts,
  ChartContainer,
  ChartRow,
  YAxis,
  LineChart,
  Resizable
} from "react-timeseries-charts";

// const user_data = require('../data/user_info.json');
// const health_data = require('../data/health_data.json');
const backendAddress = "192.168.0.155"


class Dashboard extends Component {
    state = {
        user_data: {},
        health_data: {},
        name: ''
    }
    componentDidMount() {
        const token = getToken();
        const name = getUser();
        fetch(`http://${backendAddress}:8000/api/healthStatic/${token}/`)
          .then(res => res.json())
          .then(
            (result) => {
              this.setState({
                name: name,
                user_data: result
              });
            },
            // Note: it's important to handle errors here
            // instead of a catch() block so that we don't swallow
            // exceptions from actual bugs in components.
            (error) => {
                console.log(error);
            }
        )
        fetch(`http://${backendAddress}:8000/api/healthDynamic/${token}/`)
          .then(res => res.json())
          .then(
            (result) => {
              this.setState({
                health_data: result
              });
            },
            // Note: it's important to handle errors here
            // instead of a catch() block so that we don't swallow
            // exceptions from actual bugs in components.
            (error) => {
                console.log(error);
            }
        )
      }
    
    render () {
        if (this.state.user_data.length > 0 && this.state.health_data.length > 0) {
            const user_data = this.state.user_data[0];
            const health_data = this.state.health_data;
            let step_data = [];
            let heart_data = [];
            for (var i = 0; i < health_data.length; i++) {
                // console.log(health_data[i]);
                let time = parseInt(health_data[i].TimeStamp);
                // var time = new Date(health_data[i].timestamp);
                // time = parseInt(time.getTime());
                let step = parseInt(health_data[i].stepscount);
                let heart = parseInt(health_data[i].heartrate);
                
                step_data.push([time, step]);
                heart_data.push([time, heart]);
            }
            // console.log(heart_data[0][0]);
            // heart_data = heart_data.sort((a, b) => b[0] - a[0]);

            // step_data = step_data.sort((a, b) => b[0] - a[0]);

            const series1 = new TimeSeries({
                name: "Step Count",
                columns: ["time", "value"],
                points: step_data
            });

            const series2 = new TimeSeries({
                name: "Heart Rate",
                columns: ["time", "heart_rate"],
                points: heart_data
            });

            return (
                <div className='dashboard'>
                    <h3>Dashboard</h3>
                    <div>
                        <h4> Name: {this.state.name}</h4>
                        <p> Age: {user_data.age}</p>
                        <p> Sex: {user_data.sex}</p>
                        <p> Blood Type: {user_data.bloodType}</p>
                    </div>
                    <div className='graphs'>
                        <Resizable>
                            <ChartContainer timeRange={series2.range()}>
                                <ChartRow height="150">
                                    <YAxis id="step" label="Step" width="50" min={series1.min()} max={series1.max()}  />
                                    <Charts>
                                        <LineChart axis="step" series={series1} />
                                        <LineChart axis="heart" series={series2}/>
                                    </Charts>
                                    
                                
                                    <YAxis id="heart" label="Heart Rate" width="50" min={series2.min()} max={series2.max()}  />
                                    
                                    
                                </ChartRow>
                            </ChartContainer>
                        </Resizable>
                    </div>
                    
                </div>
            );
        }
        else {
            return (
                <div>
                    Loading .....
                </div>
            )
        }
    }
}
 
export default Dashboard;