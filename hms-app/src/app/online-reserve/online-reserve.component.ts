import { Component, OnInit } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-online-reserve',
  templateUrl: './online-reserve.component.html',
  styleUrls: ['./online-reserve.component.css']
})
export class OnlineReserveComponent implements OnInit {

  constructor(public http: HttpClient) { }

  docs:any

  ngOnInit()
  {
      var currentUser = JSON.parse(localStorage.getItem('currentUser'));
      var token = currentUser.token; // your token
      var tok=token
      const httpOptions = {
      headers: new HttpHeaders({
        'Authorization': "Token"+" "+tok
      })
    };

    this.http.get("http://127.0.0.1:8000/users/docs/")
    
    .subscribe(
    data  => {
      this.docs=data
                  
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );

    
  }


  submit(params:any)
  {
    console.log(params)
  }

}
