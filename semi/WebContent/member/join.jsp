<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 화면</title>
 <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
</head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<script src="https://cdn.jsdelivr.net/jquery.validation/1.15.1/jquery.validate.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<style>
		body, html{
			width: 100%;
		    height: 100%;
		    margin: 0;
		    padding: 0;
		    display:table;
       /*  padding-top:4.2rem;
		padding-bottom:4.2rem; */
		background:rgba(0, 0, 0, 0. 100);
        }
        body {
		    display:table-cell;
		    vertical-align:middle;
		}
		form {
		    display:table;/* shrinks to fit content */
		    margin:auto;
		}
        a{
         text-decoration:none !important;
         }
         h1,h2,h3{
         font-family: 'Kaushan Script', cursive;
         }
          .myform{
		position: relative;
		display: -ms-flexbox;
		display: flex;
		padding: 1rem;
		-ms-flex-direction: column;
		flex-direction: column;
		width: 100%;
		pointer-events: auto;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid rgba(0,0,0,.2);
		border-radius: 1.1rem;
		outline: 0;
		max-width: 500px;
		 }
         .tx-tfm{
         text-transform:uppercase;
         }
         .mybtn{
         border-radius:50px;
         }
        
         .login-or {
         position: relative;
         color: #aaa;
         margin-top: 10px;
         margin-bottom: 10px;
         padding-top: 10px;
         padding-bottom: 10px;
         }
         .span-or {
         display: block;
         position: absolute;
         left: 50%;
         top: -2px;
         margin-left: -25px;
         background-color: #fff;
         width: 50px;
         text-align: center;
         }
         .hr-or {
         height: 1px;
         margin-top: 0px !important;
         margin-bottom: 0px !important;
         }
          form .error {
         color: #ff0000;
         }
		         
		.login_div {
		    position: absolute;
		
		    width: 300px;
		    height: 300px;
		
		    /* Center form on page horizontally & vertically */
		    top: 20%;
		    left: 50%;
		    margin-top: -150px;
		    margin-left: -150px;
		}
		
		.login_form {
		    width: 300px;
		    height: 300px;
		
		    border-radius: 10px;
		
		    margin: 0;
		    padding: 0;
		}
		.scroll::-webkit-scrollbar {
		   display: none;
		 }
		 
		 textarea {
		 	margin-left: 13px;
		 	margin-top: 10px;
		 }
		 
		 .check{
		 	 background-color: #FA8072;
			  border: none;
			  color: white;
			  padding: 3px;
			  text-align: center;
			  text-decoration: none;
			  display: inline-block;
			  font-size: 16px;
			  margin: 2px 2px;
			  border-radius: 8px;
		 }
		 
		 .hidden {
		 /* display: none;  */
		 }
</style>

<script>
	//약관동의 
	function myFunction() {
		  // Get the checkbox
		  var checkBox = document.getElementById("myCheck");
		  // Get the output text
		  var text = document.getElementById("text");
	
		  // If the checkbox is checked, display the output text
		  if (checkBox.checked == true){
		    text.style.display = "block";
		  } else {
		    text.style.display = "none";
		  }
		}
	
	//정구표현식 검사 
  	 $(function(){
            $(".checkID").click(function(){
                var idn = document.getElementById("idn");
                //정규표현식
                var idPattern =/^[a-zA-Z0-9]{5,20}$/;

                if(idPattern.test(idn.value) == true){//아이디 정규표현식이 만족할경우
                    $("input[name=result1]").val("통과!");
                }
                else{
                    $("input[name=result1]").val("5~20자리의 영문 대소문자와 숫자로만 입력"); //불만족
                }
               
            });
            
            
             $(".checkPW").click(function(){
                var pwn = document.getElementById("pwn");
                //정규표현식
                var pwPattern = /^[a-zA-Z0-9]{5,20}$/;

                if(pwPattern.test(pwn.value) == true){//비밀번호 정규표현식이 만족할경우
                    $("input[name=result2]").val("통과!");
                }
                else{
                    $("input[name=result2]").val("5~20자리의 영문 대소문자와 숫자로만 입력");
                }
            }); 
             
             
         	$(".regist-form").submit(function(e){
    			
                var idn = document.getElementById("idn");
                var pwn = document.getElementById("pwn");

                var idPattern =/^[a-zA-Z0-9]{5,20}$/;
                var pwPattern = /^[a-zA-Z0-9]{5,20}$/;

                if(idPattern.test(idn.value) == true && pwPattern.test(pwn.value) == true){
                	return true 
                }else {
                	e.preventDefault();
                }
    		})
        });
</script>
<body>
	 <div class="login_div">
        <div class="form login_form" >
		
			  <div >
			      <div class="myform">
                        <div>
                           <div class="col-md-12 text-center">
                              <h1 >Register</h1>
                           </div><br>
                        </div>
                        <form method ="post" action="join.do" class="regist-form" name="registration" >
                           <div class="form-group">
                              <label for="exampleInputEmail1">아이디</label>
                              <input type="text"  name="member_id" id="idn" class="form-control" aria-describedby="emailHelp" placeholder="Enter Your ID" required>
                              <input type="button" value="아이디 검사" class="checkID check">
                              <br>
                              <div>
                              	<input type="text" name="result1" size="40" style="border:none; font-size:12px; color:red">
                              </div>
   						      
                             
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">비밀번호</label>
                              <input type="password"  name="member_pw" id="pwn" class="form-control"  aria-describedby="emailHelp" placeholder="Enter Your Password" required>
                               <input type="button" value="비밀번호 검사" class="checkPW check">
                              <br>
                              <div>
                              	<input type="text" name="result2" size="40" style="border:none; font-size:12px; color:red">
                              </div>
                              
                           </div>
                           <div class="form-group">
                              <label for="exampleInputEmail1">닉네임</label>
                              <input type="text" name="member_nick"  class="form-control" aria-describedby="emailHelp" placeholder="Enter Your Nickname" required>
                           </div>
                           <hr>
                             <div class="col-md-12 ">
                              <div class="form-group">
                                 	<label style="font-size:12px">
                                 		<input type="checkbox" id="myCheck" onclick="myFunction()"  required>
                                 		<span >디비고 사이트 이용약관에 동의하십니까?</span>
                                 		  <textarea class="text-center scroll" style="font-size:12px;" rows="4" cols="30">디비고에 오신걸 환영합니다.
												디비고 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 디비고 서비스의 이용과 관련하여 디비고 서비스를 제공하는 디비고 주식회사(이하 ‘디비고’)와 이를 이용하는 디비고 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 디비고 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
										  </textarea>
                                 	</label>
                                 	<p class="text-center" id="text" style="display:none; font-size:13px ">이용약관에 동의하셨습니다!</p>
                              </div>
                           </div>
                          
                           <div class="col-md-12 text-center mb-3">
                              <button type="submit" class=" btn btn-block mybtn btn-primary tx-tfm">회원가입</button>
                           </div>
                           <div class="col-md-12 ">
                              <div class="form-group">
                                 <p class="text-center"><a href="login.jsp" id="signin">로그인 화면으로 돌아가기 </a></p>
                              </div>
                           </div>
                        </form>
                     </div>
			</div>
		</div>
      </div>   
</body>
</html>