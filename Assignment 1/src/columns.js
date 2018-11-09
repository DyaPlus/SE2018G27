import React from 'react';
import matchSorter from 'match-sorter'

const columnsProfile = [{
    Header: 'ID',
    accessor: 'id' // String-based value accessors!
  },{
    Header: 'First Name',
    accessor: 'firstname', // String-based value accessors!
    filterMethod: (filter, rows) =>
                  matchSorter(rows, filter.value, { keys: ["firstname"] }),
                  filterAll: true
  }, {
    Header: 'Last Name',
    accessor: 'lastName',
    Cell: props => <span className='number'>{props.value}</span>,
    filterMethod: (filter, rows) =>
                  matchSorter(rows, filter.value, { keys: ["lastName"] }),
                  filterAll: true
  }]

  const columnsCourse = [{
    Header: 'ID',
    accessor: 'id',
  },{
    Header: 'Name',
    accessor: 'Name',
    filterMethod: (filter, rows) =>
                  matchSorter(rows, filter.value, { keys: ["Name"] }),
                  filterAll: true
  }, {
    Header: 'Max Grades',
    accessor: 'Max_Grades',
  }, {
    Header: 'Study Years',
    accessor: 'Study_Years',
  }]

  const columnsGrade = [{
    Header: 'Grade',
    accessor: 'grade',
  },{
    Header: 'Course',
    id:"course_name",
    accessor: props => props.name,
    filterMethod: (filter, rows) =>
                  matchSorter(rows, filter.value, { keys: ["course_name"] }),
                  filterAll: true
  }, {
    Header: 'Student',
    id:"student_name",
    accessor: props => props.firstname + " " + props.lastName,
    filterMethod: (filter, rows) =>
    matchSorter(rows, filter.value, { keys: ["student_name"] }),
    filterAll: true
}]

  export default {columnsProfile,columnsCourse,columnsGrade};
