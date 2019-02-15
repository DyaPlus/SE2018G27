import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
import { DomSanitizer, SafeResourceUrl, SafeUrl} from '@angular/platform-browser';

@Component({
  selector: 'app-reports',
  templateUrl: './reports.component.html',
  styleUrls: ['./reports.component.css']
})
export class ReportsComponent implements OnInit {

  
  
  //The url will be the API of django
  private url = "https://jsonplaceholder.typicode.com/todos";
  
  //HTTP Client is for the POST/GET requests.
  constructor(private http: HttpClient,private sanitizer: DomSanitizer) { }

  ngOnInit() {}

  target:any
  content:any
  title:any
  url_1:any
  blob_1:any
  ahmed=0;

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
    this.content=params.value["content"];
    this.title=params.value["title"];
    

    this.http.post("http://127.0.0.1:8000/users/genreport/",
    {
    "target":  this.target,
    "content":  this.content,
    "title":  this.title,
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










