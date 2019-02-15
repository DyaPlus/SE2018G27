import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';

@Component({
  selector: 'app-feedback',
  templateUrl: './feedback.component.html',
  styleUrls: ['./feedback.component.css']
})
export class FeedbackComponent implements OnInit {

  constructor(private http: HttpClient) { }

  ngOnInit() {
  }

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

  var title = params.value['title']        
  var content = params.value['content']
  this.http.post("http://127.0.0.1:8000/users/submit_feedback/",
    {
    "title":  title,
    "content": content,
    },{headers:httpOptions.headers})
    
    .subscribe(
    data  => {
    
    console.log(data)
    
    
    
    
    
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );
    
  
}
}
