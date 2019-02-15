import React, { Component } from 'react';

class CourseForm extends Component {

    state = {name:"",maxGrades:"",studyYears:""}
    componentDidMount() {
        if(this.props.data) {
            this.setState({name:this.props.data.Name,maxGrades:this.props.data.Max_Grades,studyYears:this.props.data.Study_Years})
        }
    }
    onChange = (e) => {
        switch(e.target.name) {
            case "name":this.setState({name:e.target.value})
            break;
            case "maxGrades":this.setState({maxGrades:e.target.value})
            break;
            case "studyYears":this.setState({studyYears:e.target.value})
            break;


            }
        }
   
    renderButton = () => {
        if (this.props.mode == "a") {
            return <button onClick={() => {
                this.props.onSubmit(this.state.name,this.state.maxGrades,this.state.studyYears)
                this.setState({name:"",maxGrades:"",studyYears:""})
                }}>Add</button>
        }
        else {
            return <div><button onClick={() => {
                this.props.onUpdate(this.props.data.id,this.state.name,this.state.maxGrades,this.state.studyYears,this.props.index)
                }}>Update</button>
                <button onClick={() => {
                this.props.onDelete(this.props.data.id,this.props.index)
                }}>Delete</button>
                </div>
        }
    }
    render() {        
        return(<div align="center">
      Name<input type="text" name="name" value={this.state.name} onChange={this.onChange}/>
      <br />
      Max Grades<input type="text" name="maxGrades" value={this.state.maxGrades} onChange={this.onChange}/>
      <br />
      Study Year<input type="text" name="studyYears" value={this.state.studyYears} onChange={this.onChange}/>
      <br />
      {this.renderButton()}
      </div>);

      }
}

export default CourseForm;