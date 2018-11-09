import client from "../Api_Calls/client";
import React, { Component } from 'react';
import ItemList from '../ItemList';
import GradeForm from "../forms/GradeForm";

class StudentsTable extends Component{

gradeFunctions = {
    onUpdate:(id,grade,student,course,index) => {
    if (grade == "") 
    return;
    client.put(`/grade/${id}`,{grade,course,student})
    .then((response) => {
    this.props.setData(response.data,"update",index)
  })
    .catch((error) =>{
     console.log(error);
    })
  },
    onSubmit:(grade,student,course) => {
    if (grade == "") 
    return;
    client.post('/grade/',{grade,course,student})
    .then((response) => {
    this.props.setData(response.data,"submit")
     })
    .catch((error) =>{
     console.log(error);
    })},
    onDelete:(id,index) => {
        client.delete(`/grade/${id}/`)
        .then((response) => {
        this.props.setData([],"delete",index)
      })
        .catch((error) =>{
         console.log(error);
        })
      }
}

render() {
  return(<div>
  <div align="center">
  <span>ADD NEW Grade</span>
  </div>
  <br />
  <GradeForm mode="a" onSubmit={this.gradeFunctions.onSubmit}/>
  <br />
  <ItemList page={this.props.page}
  onDelete={this.gradeFunctions.onDelete} 
  onUpdate={this.gradeFunctions.onUpdate} 
  data={this.props.data} />
  </div>)
}
} 

export default StudentsTable