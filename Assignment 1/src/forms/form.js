import React, { Component } from 'react';

class Form extends Component {

    state = {firstname:"",lastname:""}
    componentDidMount() {
        if(this.props.data) {
            this.setState({firstname:this.props.data.firstname,lastname:this.props.data.lastName})
        }
    }
    onChange = (e) => {
            (e.target.name=="firstname")?this.setState({firstname:e.target.value}):this.setState({lastname:e.target.value})
        }
   
    renderButton = () => {
        if (this.props.mode == "a") {
            return <button onClick={() => {
                this.props.onSubmit(this.state.firstname,this.state.lastname)
                this.setState({firstname:"",lastname:""})
                }}>Add</button>
        }
        else {
            return <div><button onClick={() => {
                this.props.onUpdate(this.props.data.id,this.state.firstname,this.state.lastname,this.props.index)
                }}>Update</button>
                <button onClick={() => {
                this.props.onDelete(this.props.data.id,this.props.index)
                }}>Delete</button>
                </div>
        }
    }
    render() {        
        return(<div align="center">
      First Name<input type="text" name="firstname" value={this.state.firstname} onChange={this.onChange}/>
      <br />
      Last Name<input type="text" name="lastname" value={this.state.lastname} onChange={this.onChange}/>
      <br />
      {this.renderButton()}
      </div>);

      }
}

export default Form;