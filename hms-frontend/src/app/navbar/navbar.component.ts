import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent implements OnInit {

  constructor() { }
  reg_or_not:boolean
  doc_or_not:boolean

  
  ngOnInit() {


    setInterval(() => { 
      var currentUser = JSON.parse(localStorage.getItem('currentUser'));
      if (currentUser==null)
      {

        this.reg_or_not=false;

      }
      else
      {
        this.reg_or_not=true
        var type=currentUser.type

        if (type=="D")
        {
          this.doc_or_not=true
        }
        else
        {
          this.doc_or_not=false
        }
      }
    },100);
  
  }
 
  deletetoken()
  {
    localStorage.removeItem('currentUser');
  }
  

}
