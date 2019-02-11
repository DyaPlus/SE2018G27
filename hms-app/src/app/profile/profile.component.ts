import { Component, OnInit } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  constructor(public http: HttpClient) { }
  currentUser = JSON.parse(localStorage.getItem('currentUser'));
  token = this.currentUser.token;
  tok=this.token
  httpOptions = {
      headers: new HttpHeaders({
        'Authorization': "Token"+" "+this.tok
      })
    };
  
  info:any

  get_reports()
  {

  }

  get_reservations()
  {
    
  }
  ngOnInit() 
  {
    this.http.get("http://127.0.0.1:8000/users/profile/",this.httpOptions)
    
    .subscribe(
    data  => {
      this.info=data
      console.log(data)
                  
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );


  }
  

}
