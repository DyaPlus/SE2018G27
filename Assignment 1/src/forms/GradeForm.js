import React, { Component } from 'react';

class GradeForm extends Component {

    state = {grade:"",student:"",course:""}
    componentDidMount() {
        if(this.props.data) {
            this.setState({grade:this.props.data.grade,student:this.props.data.student,course:this.props.data.course,})
        }
    }
    onChange = (e) => {
        switch(e.target.name) {
            case "grade":this.setState({grade:e.target.value})
            break;
            case "student":this.setState({student:e.target.value})
            break;
            case "course":this.setState({course:e.target.value})
            break;
            }
        }
   
    renderButton = () => {
        if (this.props.mode == "a") {
            return <button onClick={() => {
                this.props.onSubmit(this.state.grade,this.state.student,this.state.course)
                this.setState({grade:"",student:"",course:""})
                }}>Add</button>
        }
        else {
            return <div><button onClick={() => {
                this.props.onUpdate(this.props.data.id,this.state.grade,this.state.student,this.state.course,this.props.index)
                }}>Update</button>
                <button onClick={() => {
                this.props.onDelete(this.props.data.id,this.props.index)
                }}>Delete</button>
                </div>
        }
    }
    renderForm = () => {
        if (this.props.mode == "a") {
            return <div>
                Grade<input type="text" name="grade" value={this.state.grade} onChange={this.onChange}/>
                <br />
                Student ID <input type="text" name="student" value={this.state.student} onChange={this.onChange}/>
                <br />
                Course ID <input type="text" name="course" value={this.state.course} onChange={this.onChange}/>
                <br />
            </div>
        }
        else {
            return <div>Grade<input type="text" name="grade" value={this.state.grade} onChange={this.onChange}/>
                    <br />
                </div>
        }
    }
    render() {        
        return(<div align="center">
      {this.renderForm()}
      {this.renderButton()}
      </div>);

      }
}

export default GradeForm;