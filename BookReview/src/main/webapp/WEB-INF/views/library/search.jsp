<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Book Review</title>
	<style>
		/* ��� �޴� �ӽ� ���ø� */
		
		 .navbar {
		   display: flex;
		   justify-content: center;
		   align-items: center;
		   background-color: #f0f2f1;
		   padding: 10px 0;
		   box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		 }
		
		 .navbar div {
		   margin: 0 15px;
		   padding: 10px 20px;
		   background-color: #d5e8d4;
		   border-radius: 5px;
		   cursor: pointer;
		 }
		
		 .navbar div:hover {
		   background-color: #a8d08d;
		 }
		
		 .navbar div.active {
		   background-color: #b3e5ab;
		 }
		
		 .navbar div.dropdown {
		   position: relative;
		 }
		
		 .navbar div.dropdown-content {
		   display: none;
		   position: absolute;
		   top: 40px;
		   left: 0;
		   background-color: #6e7b69;
		   border-radius: 5px;
		   padding: 10px;
		   text-align: left;
		   box-shadow: 0 4px 8px rgba(0,0,0,0.1);
		 }
		
		 .navbar div.dropdown:hover .dropdown-content {
		   display: block;
		 }
		
		 .navbar div.dropdown-content div {
		   padding: 5px 0;
		   color: white;
		 }
		
		 .navbar div.dropdown-content div:hover {
		   background-color: #4a5148;
		   cursor: pointer;
		 }
	
	/* -------------------------------------------------------- */
	
		body {
	    	text-align: center;
	  	}	
		#map {
		  width: 1000px;
		  height: 550px;
		  margin: 0 auto;
		  
		}
		form {
			margin: 20px 0;
		}
		
		input[type="text"] {
			width: 400px;
			height: 35px;
			padding: 0 10px;
			font-size: 16px;
			border: 1px solid #ccc;
			border-radius: 5px;
			box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		}
		
		button {
			height: 40px;
			padding: 0 20px;
			font-size: 16px;
			background-color: #4CAF50;
			color: white;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			margin-left: 10px;
			box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		}
		
		button:hover {
			background-color: #45a049;
		}
		
		
		.table-container {
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
			margin: 20px auto;
			width: 90%;
		}

		table {
			width: 30%; /* ���̺��� 3���� ���� �� �ֵ��� ���� */
			border-collapse: collapse;
			margin-bottom: 20px;
			box-shadow: 0 2px 5px rgba(0,0,0,0.1);
		}
		
		th, td {
			padding: 8px 12px;
			border: 1px solid #ccc;
		}

		th {
			background-color: #f0f2f1;
			text-align: left;
		}

		td {
			text-align: center;
		}
		#scrollToTopBtn {
			display: none;
			position: fixed;
			bottom: 40px;
			right: 40px;
			z-index: 99;
			background-color: #4CAF50;
			color: white;
			border: none;
			padding: 10px 15px;
			border-radius: 50%;
			cursor: pointer;
			box-shadow: 0 2px 5px rgba(0,0,0,0.3);
			font-size: 18px;
		}
	</style>
		
</head>
<body>
	<!-- ��� �޴� -->
	<div class="navbar">
	  <div class="active">HOME</div>
	  <div class="dropdown">
	    ���� å
	    <div class="dropdown-content">
	      <div>����</div>
	      <div>����</div>
	      <div>�ϸ�ũ</div>
	    </div>
	  </div>
	  <div>��õ ����</div>
	  <div>��� �Խ���</div>
	  <div>�˻�</div>
	  <div>������ ã��</div>
	  <div>ȫ�浿�� ȯ���մϴ�.</div>
	</div>

	<h1 id="page_name">������ / �ּ� �˻�</h1>
	
	<div>
		<div id="map"></div>
	</div>
	
	<form method="GET" action="search.do">
        <input type="text" name="search" placeholder="�˻��� ���Ͻô� (��)�� �Է��ϼ���.">
        <button type="submit">�˻�</button>
    </form>
	
	<hr>
	
	<div id="result_box">�˻� ����Դϴ�</div>
	
	<c:if test="${not empty libraryList}">
        <table border="1">
            <tr>
                <th>��Ҹ�</th>
                <th>�ּ�</th>
                <th>ī�װ�</th>
            </tr>
            <c:forEach var="library" items="${libraryList}">
                <tr>
                    <td>${library.name}</td>
                    <td>${library.address}</td>
                    <td>${library.category}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
	
	<button id="scrollToTopBtn" title="�� ����">&#8679;</button>
	
	
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3018135f77d0e580f8314f4923a20f61"></script>
	<script>
	    var libraryList = [];
	    
	    <c:forEach var="library" items="${libraryList}">
	        libraryList.push({
	            lat: ${library.lat},
	            lng: ${library.lng},
	            name: "${library.name}"
	        });
	    </c:forEach>
	
	    var mapContainer = document.getElementById('map');
	    var mapOption = {
	        center: new kakao.maps.LatLng(37.5665, 126.9780),
	        level: 3
	    };
	    
	    var map = new kakao.maps.Map(mapContainer, mapOption);
	
	    libraryList.forEach(function(library) {
	        var markerPosition = new kakao.maps.LatLng(library.lat, library.lng);
	        var marker = new kakao.maps.Marker({
	            position: markerPosition,
	            map: map
	        });
	
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="padding:5px;">' + library.name + '</div>'
	        });
	
	        kakao.maps.event.addListener(marker, 'mouseover', function() {
	            infowindow.open(map, marker);
	        });
	
	        kakao.maps.event.addListener(marker, 'mouseout', function() {
	            infowindow.close();
	        });
	    });
		

		var scrollToTopBtn = document.getElementById("scrollToTopBtn");

		window.onscroll = function() {
			scrollFunction();
		};

		function scrollFunction() {
			if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
				scrollToTopBtn.style.display = "block";
			} else {
				scrollToTopBtn.style.display = "none";
			}
		}

		// �ε巴�� ������ �� ���� ��ũ���ϴ� �Լ�
		scrollToTopBtn.onclick = function() {
			smoothScrollToTop();
		};

		function smoothScrollToTop() {
			var currentPosition = document.documentElement.scrollTop || document.body.scrollTop;
			if (currentPosition > 0) {
				window.requestAnimationFrame(smoothScrollToTop);
				window.scrollTo(0, currentPosition - currentPosition / 10); 
			}
		}
		
	</script>
</body>
</html>