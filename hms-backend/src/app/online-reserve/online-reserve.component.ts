import { Component, OnInit } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-online-reserve',
  templateUrl: './online-reserve.component.html',
  styleUrls: ['./online-reserve.component.css']
})
export class OnlineReserveComponent implements OnInit {

  constructor(public http: HttpClient,public router:Router) { }

  docs:any

  currentUser = JSON.parse(localStorage.getItem('currentUser'));
  token = this.currentUser.token; // your token
  tok=this.token
  httpOptions = {
      headers: new HttpHeaders({
        'Authorization': "Token"+" "+this.tok
      })
    };

  ngOnInit()
  {
         
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


  changer=0
  slots:any
  selected_doc:any 
  selected_slot:any
  error=false

  submit(params:any)
  {
    this.changer=1
    console.log(params)
    this.selected_doc=params
    this.http.get("http://127.0.0.1:8000/users/queryslot/"+params+"/",this.httpOptions)
    
    .subscribe(
    data  => {
      //console.log(data)
      this.slots=data
      this.error=false
                  
    },
    
    error  => {
    this.error=true
    
    }
    
    );


  }

  reserve_slot(params:any)
  {
    this.selected_slot=params
    this.http.post("http://127.0.0.1:8000/users/reserveslot/",
    {
    "slot_id":  this.selected_slot
   
    },this.httpOptions)
    
    .subscribe(
    data  => {
     // console.log(data)
     this.router.navigateByUrl("/HomePage")

    //console.log(data)
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );
       
  
  }

  }

