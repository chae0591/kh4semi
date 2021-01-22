<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

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
</style>


</head>
<body>
	 <div class="login_div">
        <div class="form login_form" >
		
			  <div >
			      <div class="myform">
                        <div>
                           <div class="col-md-12 text-center">
                              <h1>Find Your Password</h1>
                           </div><br>
                        </div>
                        <form method ="post" action="findpw.do" >
                           <div class="form-group">
                              <label>아이디</label>
                              <input type="text"  name="member_id" class="form-control" placeholder="Enter Your ID" maxlength='20' required>
                           </div>
                           <div class="form-group">
                              <label>닉네임</label>
                              <input type="text"  name="member_nick" class="form-control" placeholder="Enter Your Nickname" maxlength='20' required>
                           </div>
                          
                          	<%if(request.getParameter("error")!=null){ %>
							<script>alert('비밀번호 찾기 실패! \n아이디와 닉네임을 다시 확인해주세요.');</script>
							<%} %>
				           <br>               
                           <div class="col-md-12 text-center mb-3">
                              <button type="submit" class=" btn btn-block mybtn btn-primary tx-tfm">비밀번호 찾기</button>
                           </div>
                        </form>
                     </div>
			</div>
		</div>
      </div>   







<!-- 
	<form method="post" action="findpw.do">
		<h3>비밀번호 찾기</h3>
		<div>
			<input type ="text" placeholder="아이디" name ="member_id" maxlength='20'>
		</div><br>
		<div>
			<input type ="text" placeholder="닉네임" name ="member_nick" maxlength='20'>
		</div><br>
		<div>
			<input type="submit" value="비밀번호 찾기">
		</div> 
		
	</form> -->


	
</body>
</html>