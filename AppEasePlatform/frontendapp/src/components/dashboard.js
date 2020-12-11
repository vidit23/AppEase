import React, { Component } from 'react';
import { Redirect } from "react-router-dom";
import { TimeSeries, Index } from "pondjs";
import {
  Charts,
  ChartContainer,
  ChartRow,
  YAxis,
  LineChart,
  Resizable
} from "react-timeseries-charts";

const user_data = require('../data/user_info.json');
const health_data = require('../data/health_data.json');

class Dashboard extends Component {
    render () {
        let step_data = [];
        let walking_data = [];
        for (var i = 0; i < health_data.length; i++) {
            let time = parseInt(health_data[i].TimeStamp);
            let step = parseInt(health_data[i].stepCount);
            let walking = parseInt(health_data[i].walkingLabel);
            
            step_data.push([time, step]);
            walking_data.push([time, walking]);
        }
        const series1 = new TimeSeries({
            name: "Step Count",
            columns: ["time", "value"],
            points: step_data
        });

        const series2 = new TimeSeries({
            name: "Walk Count",
            columns: ["time", "walk"],
            points: walking_data
        });

        return (
            <div className='dashboard'>
                <h3>Dashboard</h3>
                <div>
                    <h4> Name: {user_data.name}</h4>
                    <p> Age: {user_data.age}</p>
                    <p> Sex: {user_data.sex}</p>
                    <p> Blood Type: {user_data.bloodType}</p>
                </div>
                <div className='graphs'>
                    <Resizable>
                        <ChartContainer timeRange={series1.range()}>
                            <ChartRow height="150">
                                <YAxis id="step" label="Step" width="50" min={series1.min()} max={series1.max()}  />
                                <Charts>
                                    <LineChart axis="step" series={series1} />
                                    <LineChart axis="walk" series={series2}/>
                                </Charts>
                                
                            
                                <YAxis id="walk" label="Wlak" width="50" min={series1.min()} max={series1.max()}  />
                                
                                
                            </ChartRow>
                        </ChartContainer>
                    </Resizable>
                </div>
                
            </div>
        );
    }
}
 
export default Dashboard;