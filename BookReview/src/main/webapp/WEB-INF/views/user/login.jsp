<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/rebook/assets/css/login.css" />
<%@include file="/WEB-INF/views/inc/header.jsp" %>

</head>
<body class="loginbody">
<main class="main">
<div class="container" id="container">
  <div class="form-container sign-up-container">
      <h1 class="title" style="margin-top: 150px; margin-left: 180px;">계정 생성</h1> 
    <form method="POST" action="/rebook/user/register.do" enctype="multipart/form-data">
      <div class="registerInfo" id="registerInfo1" style="margin-top: 50px;">
        <input type="text" name="name" id="name" required class="short" placeholder="Name" aria-label="Name">
        <input type="text" name="id" id="id" required class="short" placeholder="ID" aria-label="ID" />
        <input type="password" name="pw" placeholder="Password" aria-label="Password" />
        <input type="email" name="email" required placeholder="Email" aria-label="Email" />
        <input type="tel" name="tel" required placeholder="Tel" aria-label="Telephone" />
        
        <div class="nextInfo">
          <button type="button" onclick="showNextDiv()">다음 단계</button>
        </div>
      </div>

      <div class="registerInfo" id="registerInfo2" style=" visibility: hidden;">
        <input type="text" name="zipcode" id="zipcode" required class="short" placeholder="Zipcode" aria-label="Zipcode">
        <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" aria-label="Find Zipcode">
        <input type="text" name="address" id="address" required class="short" placeholder="Address" aria-label="Address">
        <input type="text" name="addrDetail" required class="short" placeholder="Detail Address" aria-label="Detail Address" />
        <input type="file" name="pic" id="pic" class="long" aria-label="Profile Picture">
        
        <div class="nextInfo">
          <button type="button" onclick="showBeforeDiv()">이전 단계</button>
        </div>
      <div class="btnSignUp">
        <button type="submit">회원가입</button> 
      </div>  
      </div>

    </form>
  </div>

	  <div class="form-container sign-in-container">
	    <form method="POST" action="/rebook/user/login.do">
	      <h1 class="title">로그인</h1> 
	      <input type="text" placeholder="id" name="id"/>
	      <input type="password" placeholder="Password" name="pw"/>
	      <a href="#" class="forgot">아이디/비밀번호 찾기</a>
	      <button>로그인</button><!-- 로그인 -->
	    </form>
	  </div>
	  <div class="overlay-container">
	    <div class="overlay">
	      <div class="overlay-panel overlay-left">
	        <h1 class="titlecomment">다시 오셨군요!</h1>
	        <p>이미 계정이 있다면 로그인 해주세요.</p>
	        <button class="ghost" id="signIn">로그인</button><!-- 전환 -->
	      </div>
	      <div class="overlay-panel overlay-right">
	        <h1 class="titlecomment">처음이신가요?</h1>
	        <p>지금 바로 가입해 보세요!</p>
	       	<button class="ghost" id="signUp">회원가입</button>
	      </div>
	    </div>
	  </div>
	</div>
</main>
</body>
        
 	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>

	
	
		const signUpButton = document.getElementById('signUp');
		const signInButton = document.getElementById('signIn');
		const container = document.getElementById('container');
	
		signUpButton.addEventListener('click', () => {
		  container.classList.add("right-panel-active");
		});
	
		signInButton.addEventListener('click', () => {
		  container.classList.remove("right-panel-active");
		});
		function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    
                    var addr = ''; 
                    var extraAddr = ''; 

            
                    if (data.userSelectedType === 'R') { 
                        addr = data.roadAddress;
                    } else { 
                        addr = data.jibunAddress;
                    }

                   
                    if(data.userSelectedType === 'R'){
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }

                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }

                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById("address").value = addr;
                }
            }).open();
        }
        function showNextDiv() {
            document.getElementById('registerInfo1').style.visibility= 'hidden';
            document.getElementById('registerInfo2').style.visibility= 'visible';
            document.getElementById('registerInfo2').style.marginTop = '-640px';
        }
        function showBeforeDiv() {
            document.getElementById('registerInfo1').style.visibility= 'visible';
            document.getElementById('registerInfo2').style.visibility= 'hidden';
            document.getElementById('registerInfo2').style.marginTop = '0px';
        }
        
       
        

	</script>
</html>
