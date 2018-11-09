import client from "../Api_Calls/client";
import React, { Component } from 'react';
import ItemList from '../ItemList';
import Form from '../forms/CourseForm'
import CourseForm from "../forms/CourseForm";

class StudentsTable extends Component{

courseFunctions = {
    onUpdate:(id,Name,Max_Grades,Study_Years,index) => {
    if (Name == "") 
    return;
    client.put(`/course/${id}`,{Name,Max_Grades,Study_Years})
    .then((response) => {
    this.props.setData(response.data,"update",index)
  })
    .catch((error) =>{
     console.log(error);
    })
  },
    onSubmit:(Name,Max_Grades,Study_Years) => {
    if (Name == "") 
    return;
    client.post('/course/',{Name,Max_Grades,Study_Years})
    .then((response) => {
    this.props.setData(response.data,"submit")
     })
    .catch((error) =>{
     console.log(error);
    })},
    onDelete:(id,index) => {
        client.delete(`/course/${id}/`)
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
  <span>ADD NEW COURSE</span>
  </div>
  <br />
  <CourseForm mode="a" onSubmit={this.courseFunctions.onSubmit}/>
  <br />
  <ItemList page={this.props.page}
  onDelete={this.courseFunctions.onDelete} 
  onUpdate={this.courseFunctions.onUpdate} 
  data={this.props.data} />
  </div>)
}
} 

export default StudentsTable