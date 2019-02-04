import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  constructor(public http: HttpClient) { }

  ngOnInit() {
  }

  username:any;
  mobile:any;
  password:any;
  password2:any;
  full_name:any;
  type:any;
  national_id:any;
  
  
  
  submit(params:any) 
  {
    
    this.mobile=params.value["mobile"];
    this.username=params.value["username"];
    this.password=params.value["password"];
    this.password2=params.value["password2"];
    this.full_name=params.value["full_name"];
    this.type=params.value["type"];
    this.national_id=params.value["national_id"];

    this.http.post("http://127.0.0.1:8000/users/signup/",
    {
    "username":  this.username,
    "mobile":  this.mobile,
    "password":  this.password,
    "password2":  this.password2,
    "full_name":  this.full_name,
    "type":  this.type,
    "national_id":  this.national_id,
    })
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
