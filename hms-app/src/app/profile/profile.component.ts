import { Component, OnInit } from '@angular/core';
import { HttpHeaders } from '@angular/common/http';
import { HttpClient } from '@angular/common/http';
import { DomSanitizer, SafeResourceUrl, SafeUrl} from '@angular/platform-browser';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  constructor(public http: HttpClient,private sanitizer: DomSanitizer) { }
  currentUser = JSON.parse(localStorage.getItem('currentUser'));
  token = this.currentUser.token;
  tok=this.token
  httpOptions = {
      headers: new HttpHeaders({
        'Authorization': "Token"+" "+this.tok
      })
    };
  
  info:any
  reports:any
  reservations:any
  id:any
  url_1:any
  get_my_id()
  {
    this.http.get("http://127.0.0.1:8000/users/what_ip/",this.httpOptions)
    
    .subscribe(
    data  => {
      this.id=data
      //console.log(this.id)
                  
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );
 
  }
  get_reports()
  {
    var x=this.id.id;
    console.log(x)
    this.http.get("http://127.0.0.1:8000/users/getreportdetails/"+x+"/",this.httpOptions)
    
    .subscribe(
    data  => {
      this.reports=data
      console.log(data)
                  
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );

  }

  get_reservations()
  {
    
  }


  download_selected_report(report_id:any)
  {
    var user_id=this.id.id
    this.http.get("http://127.0.0.1:8000/users/getreportpdf/"+user_id+"/"+report_id+"/",
    {responseType: 'arraybuffer',headers:this.httpOptions.headers})
    .subscribe(
      data  => {
      console.log(data)
      var file = new Blob([data], {type: 'application/pdf'});
      var fileURL = URL.createObjectURL(file);
      this.url_1=this.sanitizer.bypassSecurityTrustResourceUrl(fileURL)
      },
      
      error  => {
      
      console.log("Error", error);
      
      }
      
      );
    
    
  }

  killme()
  {
    return this.url_1
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

    this.get_my_id()

  }
  

}
