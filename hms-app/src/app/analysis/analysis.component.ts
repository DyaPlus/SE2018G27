import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
@Component({
  selector: 'app-analysis',
  templateUrl: './analysis.component.html',
  styleUrls: ['./analysis.component.css']
})
export class AnalysisComponent implements OnInit {

  constructor(public http: HttpClient) { }

  
  
  ngOnInit() {
    

    var currentUser = JSON.parse(localStorage.getItem('currentUser'));
    var token = currentUser.token; // your token
    const httpOptions = {
      headers: new HttpHeaders({
        'Authorization': "Token"+" "+token
      })
    };

    
    this.http.get("http://127.0.0.1:8000/users/lol/",httpOptions)
    
    .subscribe(
    data  => {
    console.log("POST Request is successful ", data);
    localStorage.setItem('currentUser', JSON.stringify({ token: data['token'], type: data['user_type'] }));
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );
  }

}
