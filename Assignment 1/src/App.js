import React, { Component } from 'react';
import StudentsTable from './tables/StudentsTable'
import client from "./Api_Calls/client";
import Menu, { MenuItem} from 'rc-menu';
import 'rc-menu/assets/index.css';
import CoursesTable from './tables/CoursesTable'
import GradesTable from './tables/GradesTable'

class App extends Component {

  state = {data:[],page:"s"}
  
  componentDidMount() {
    client.get('/profile/')
  .then((response) => {
    console.log(response);
    this.setState({data:response.data})
  })
  .catch((error) =>{
    console.log(error);
  })
  }
  
  onSelect = (key) => {
    switch(key.key) {
      case "s" :
      this.setState({page:"s",data:null}) 
      client.get('/profile/')
      .then((response) => {
        console.log(response);
        this.setState({data:response.data})
      })
      .catch((error) =>{
        console.log(error);
      })
      break;
      case "c" :
      this.setState({page:"c",data:null})
      client.get('/course/')
      .then((response) => {
        console.log(response);
        this.setState({data:response.data})
      })
      .catch((error) =>{
        console.log(error);
      })
      break;
      case "g" :
      this.setState({page:"g",data:null})
      client.get('/grade/')
      .then((response) => {
        console.log(response);
        this.setState({data:response.data})
      })
      .catch((error) =>{
        console.log(error);
      })
      break;
      default:break;

    }
  }
  setData = (data=[],mode,index=0) => {
    if (mode =="submit") {
      this.setState({data:[...this.state.data,data]})

    }
    else if (mode =="update") {
      let lol = this.state.data.slice()
      lol[index] = data
      this.setState({data : lol})
    }
    else if(mode =="delete") {
      let lol = this.state.data.slice()
      lol.splice(index,1)
      this.setState({data : lol})
    }

  }
 
  renderTable = ()=> {
    if(this.state.data)
    switch(this.state.page) {
      case "s": return <StudentsTable page={this.state.page}
      data={this.state.data}
      setData={this.setData} />
      case "c": return <CoursesTable page={this.state.page}
      data={this.state.data}
      setData={this.setData} />
      case "g": return <GradesTable page={this.state.page}
      data={this.state.data}
      setData={this.setData} />

    }
  }
  render() {
    return (<div>
      <Menu mode='horizontal' 
      onSelect={this.onSelect}
      defaultSelectedKeys={["s"]}
      >
        <MenuItem key="s">Students</MenuItem>
        <MenuItem key="c" >Courses</MenuItem>
        <MenuItem key="g">Grades</MenuItem>
      </Menu>
      <br />
      {this.renderTable()}
      </div>
      )
  
   
  }
}

export default App;
