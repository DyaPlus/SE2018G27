import client from "../Api_Calls/client";
import React, { Component } from 'react';
import ItemList from '../ItemList';
import Form from '../forms/form'

class StudentsTable extends Component{

studentFunctions = {
    onUpdate:(id,firstname,lastname,index) => {
    if (firstname == "" || lastname == "") 
    return;
    client.put(`/profile/${id}`,{firstname:firstname,lastName:lastname})
    .then((response) => {
    this.props.setData(response.data,"update",index)
  })
    .catch((error) =>{
     console.log(error);
    })
  },
    onSubmit:(firstname,lastname) => {
    if (firstname == "" || lastname == "") 
    return;
    client.post('/profile/',{firstname:firstname,lastName:lastname,year:1})
    .then((response) => {
    this.props.setData(response.data,"submit")
     })
    .catch((error) =>{
     console.log(error);
    })},
    onDelete:(id,index) => {
        client.delete(`/profile/${id}/`)
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
  <span>ADD NEW STUDENT</span>
  </div>
  <br />
  <Form mode="a" onSubmit={this.studentFunctions.onSubmit}/>
  <br />
  <ItemList page={this.props.page}
  onDelete={this.studentFunctions.onDelete} 
  onUpdate={this.studentFunctions.onUpdate} 
  data={this.props.data} />
  </div>)
}
} 

export default StudentsTable