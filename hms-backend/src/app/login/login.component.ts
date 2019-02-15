import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(public http: HttpClient,public router:Router ) { }

  ngOnInit() {
  }

  username:any
  password:any
  error=false
  errors:any

  submit(params:any) 
  {
    
   
    this.username=params.value["username"];
    this.password=params.value["password"];
   
    this.http.post("http://127.0.0.1:8000/users/signin/",
    {
    "username":  this.username,
    
    "password":  this.password,
    })
    .subscribe(
    data  => {
    this.error=false
    console.log("POST Request is successful ", data);
    localStorage.setItem('currentUser', JSON.stringify({ token: data['token'], type: data['user_type'] }));
    this.router.navigateByUrl("/HomePage")

    },
    
    error  => {
    this.errors=error
    this.error=true
    console.log("Error", error);
    
    }
    
    );
       
  
  }
  

    
  


}

