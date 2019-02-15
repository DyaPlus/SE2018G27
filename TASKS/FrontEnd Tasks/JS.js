let count=0;
function isEmpty(value){
  return (value == null || value.length === 0);
}

function toto(){
    let Name = document.getElementById('myInput').value;
    let Quntity = document.getElementById('quantity').value;
    if ( !isEmpty(Name) && !isEmpty(Quntity)){
      count++;
    document.getElementById('cover').innerHTML += 
    ` <head>
    <style>
    * {
        box-sizing: border-box;
    }
    
    
    
    table{
        border: 1px solid black;
        border-collapse: collapse;
        margin-left: 187px;
        margin-top: 50px;
        width: 72%;
        font-size: 20px;
    }
    th, td {
        
        border-collapse: collapse;
    }
    th, td {
        padding: 15px;
        text-align: left;
    }
    </style>
    </head>
    <body>
    <tr>
    <td>${Name}</td>
    <td>${Quntity}</td>
    </tr>
    </body>`;
  }
}

function pharmacy(){
  if(count > 0)
  {
    document.getElementById('mypharmacy').innerHTML = 
    `
    <style>
    * {
        box-sizing: border-box;
      }
      
      .myInput {
        background-image: url('/css/searchicon.png');
        background-position: 10px 12px;
        background-repeat: no-repeat;
        width: 30%;
        font-size: 16px;
        padding: 12px 20px 12px 40px;
        border: 1px solid #ddd;
        margin-bottom: 12px;
        margin-left: 20px
      }
      
      .Medicine {
        font-size: 18px;
        margin-left: 30px;
      }
      input[type=submit] {
        background-color: #4CAF50 ;
        color: white;
        padding: 13px 26px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-left: 40px;
        
      
      }
      </style>
    
    <label class="Medicine" for="pharmacy">Pharmacy Name:</label>
<input class ="myInput" type="text" id="pharmacy" onkeyup="myFunctionpharmacy()" placeholder="Search for pharmacies.." title="Pharmacy" list="PharmacyName">
<datalist id="PharmacyName">
    <option value="Seif">
    <option value="19011">
    <option value="ElAzaby">
    <option value="Asmaa">
    <option value="AlFala7">
  </datalist>
  <div style=" margin-top: 50px; text-align: center; " >
  <input style="padding: 15px 60px; font-size: 20px; " type="submit" value="Submit" onclick="pharmacytoto ()">
  </div>


`;
  }
  else{
    document.getElementById('mypharmacy').innerHTML = 
    `<div class="alert alert-danger alert-dismissible">
    
    <strong> Please!</strong>  Add Medicine First
  </div>`
  }
}

function pharmacytoto ()
  {
    let pharmacy = document.getElementById('pharmacy').value;
    if ( !isEmpty(pharmacy) ){
      document.getElementById('mypha').innerHTML = `<div class="alert alert-success alert-dismissible">
      <strong>Success!</strong> Prescreption has been completed.
    </div>`
    }
    else{
        document.getElementById('mypha').innerHTML = 
        `<div class="alert alert-danger alert-dismissible">
        
        <strong> Please!</strong>  Select A Pharmacy First
      </div>`
      }
        
  }