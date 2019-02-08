import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';

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

  target:any
  content:any
  title:any
  
  
  
  submit(params:any) 
  {
    var currentUser = JSON.parse(localStorage.getItem('currentUser'));
    var token = currentUser.token; // your token
    var tok=token
   const httpOptions = {
    headers: new HttpHeaders({
      'Authorization': "Token"+" "+tok
    })
                      };


    this.target=params.value["target"];
    this.content=params.value["content"];
    this.title=params.value["title"];
    

    this.http.post("http://127.0.0.1:8000/users/genreport/",
    {
    "target":  this.target,
    "content":  this.content,
    "title":  this.title,
    },{responseType: 'blob',headers:httpOptions.headers})
    
    .subscribe(
    data  => {
    
    //downloads the file
    var blob = data
    var url= window.URL.createObjectURL(blob);
    window.open(url);
    
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );
       
  
  }

    
  }










