import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from "rxjs/Observable";

@Component({
  selector: 'app-reports',
  templateUrl: './reports.component.html',
  styleUrls: ['./reports.component.css']
})
export class ReportsComponent implements OnInit {

  
  
  //The url will be the API of django
  private url = "https://jsonplaceholder.typicode.com/todos";
  
  //HTTP Client is for the POST/GET requests.
  constructor(private http: HttpClient) { }

  ngOnInit() {}

submit(params:any) 
{
  //Returns the JSON Value of a form.
  console.log(params.value)
  
}



//gets the data needed from the apii

get_from_api(): Observable<any> {

  return this.http.get<any>(this.url);
  
}

data_recieved:any

//display_data_from_api_when_click
display_results()
{
  this.get_from_api().subscribe(data => {
    this.data_recieved = data;
    console.log(this.data_recieved);
  });
 
}



}
