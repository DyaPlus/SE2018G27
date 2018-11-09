import React, { Component } from 'react';
import ReactTable from "react-table";
import 'react-table/react-table.css';
import columns from './columns.js'
import Form from './forms/form.js';
import CourseForm from './forms/CourseForm.js';
import GradeForm from './forms/GradeForm';

class ItemList extends Component {
  
  shouldComponentUpdate(nextProps) {
    if(nextProps != this.props) {
      return true
    }
  }
  renderTable = () => {
    switch(this.props.page) {
      case "s": return <ReactTable
      filterable
      data={this.props.data}
      columns={columns.columnsProfile}
      defaultFilterMethod={(filter, row) =>
        String(row[filter.id]) === filter.value}
      SubComponent={row => {
        console.log(row)
        return <Form mode="u" data={row.original} onDelete={this.props.onDelete} onUpdate={this.props.onUpdate} index={row.index} />
      }}
      />

      case "c": return <ReactTable
      filterable
      data={this.props.data}
      columns={columns.columnsCourse}
      SubComponent={row => {
        console.log(row)
        return <CourseForm mode="u" data={row.original} onDelete={this.props.onDelete} onUpdate={this.props.onUpdate}  index={row.index} />
      }}
      />

      case "g":return <ReactTable
      filterable
      data={this.props.data}
      columns={columns.columnsGrade}
      SubComponent={row => {
        console.log(row)
        return <GradeForm mode="u" data={row.original} onDelete={this.props.onDelete} onUpdate={this.props.onUpdate}  index={row.index} />
      }}
      />
      default:break;
    }
  }
    render() {
      
      return <div>{this.renderTable()}</div>

      }
}

export default ItemList;