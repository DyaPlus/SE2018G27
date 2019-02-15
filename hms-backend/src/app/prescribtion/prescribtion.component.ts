import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
import { DomSanitizer, SafeResourceUrl, SafeUrl} from '@angular/platform-browser';

@Component({
  selector: 'app-prescribtion',
  templateUrl: './prescribtion.component.html',
  styleUrls: ['./prescribtion.component.css']
})
export class PrescribtionComponent implements OnInit {

  constructor(private http: HttpClient,private sanitizer: DomSanitizer) { }

  ngOnInit() {
  }
  medicine:any
  target:any
  content:any
  title:any
  url_1:any
  blob_1:any
  found:boolean
  clicked:boolean
  //ahmed=0;
  arr=[]

  add_med()
  {
    this.arr.push(this.medicine)
  }

  searching(params:any)
  { 
    this.found=false
    this.clicked=false
    var currentUser = JSON.parse(localStorage.getItem('currentUser'));
    var token = currentUser.token; // your token
    var tok=token
   const httpOptions = {
    headers: new HttpHeaders({
      'Authorization': "Token"+" "+tok
    })
                      };
    this.medicine=params.value["medicine"]
    this.http.get("http://127.0.0.1:8000/users/medicine/"+this.medicine+"",
    httpOptions)
    
    .subscribe(
    data  => {
    this.found=true
    this.clicked=true
    },
    error  => {
    this.found=false
    this.clicked=true
    
    }
    
    )
  
  }
  ahmed=0
  killme()
  {
    return this.url_1
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


    this.target=params.value["target"];
    
    //this.content=params.value["content"];
    //this.title=params.value["title"];
    

    this.http.post("http://127.0.0.1:8000/users/genreport/",
    {
    "target":  this.target,
    "content":  this.arr.join(),
    "title":  'E',
    },{responseType: 'arraybuffer',headers:httpOptions.headers})
    
    .subscribe(
    data  => {
    
    console.log(data)
    //downloads the file
    //this.blob_1 = data
    //this.url_1= window.URL.createObjectURL(this.blob_1);
    //window.open(this.url_1)
    var file = new Blob([data], {type: 'application/pdf'});
    var fileURL = URL.createObjectURL(file);
    this.url_1=this.sanitizer.bypassSecurityTrustResourceUrl(fileURL)
    this.ahmed=1
    
    
    
    
    },
    
    error  => {
    
    console.log("Error", error);
    
    }
    
    );
       
  
  }

}
