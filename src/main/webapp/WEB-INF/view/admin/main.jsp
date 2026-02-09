<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="UTF-8">

<script src="https://cdn.tailwindcss.com"></script>

<title>관리자 페이지</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet">
</head>
<body class="overflow-hidden">

	<!-- 상단 네비게이션 바 -->
    <header class="h-16 bg-white border-b border-gray-200 shadow-sm flex items-center justify-between px-6 z-10 relative">
	    <div class="flex items-center gap-3">
	        <div class="w-10 h-10 rounded-lg overflow-hidden flex items-center justify-center bg-gray-50 border border-gray-100 shadow-sm">
	            <img src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg" alt="Logo" class="w-full h-full object-cover">
	        </div>
	        <h1 class="text-xl font-bold text-gray-900 tracking-tight bg-transparent">관리자 페이지</h1>
	    </div>
	    <div class="flex items-center gap-4">
	        <span class="text-sm text-gray-600 font-medium">관리자님 환영합니다</span>
	        <button onclick="location.href='${pageContext.request.contextPath}/index.do?page=1'" class="text-sm bg-gray-100 hover:bg-gray-200 text-gray-700 py-2 px-4 rounded-md transition-all font-medium">
	            <i class="fas fa-arrow-right-from-bracket mr-2"></i> 나가기
	        </button>
	    </div>
	</header>

	<div class="flex">
        <!-- 사이드바 -->
        <aside class="w-72 bg-white border-r border-gray-200 sidebar-scroll shadow-sm">
            <div class="p-6">
                <nav class="space-y-2">
				    <p class="text-[11px] font-bold text-gray-400 uppercase tracking-widest mb-4 px-2">Management</p>
				    <a href="#" onclick="loadContent('user')" class="menu-item active flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
				        <i class="fas fa-users w-5 group-hover:scale-110 transition-transform"></i>
				        <span class="font-bold">사용자 관리</span>
				    </a>
				    <a href="#" onclick="loadContent('product')" class="menu-item flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
				        <i class="fas fa-box w-5 group-hover:scale-110 transition-transform"></i>
				        <span class="font-bold">상품 관리</span>
				    </a>
				    <a href="#" onclick="loadContent('review')" class="menu-item flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
				        <i class="fas fa-star w-5 group-hover:scale-110 transition-transform"></i>
				        <span class="font-bold">리뷰 관리</span>
				    </a>
				    
				    <p class="text-[11px] font-bold text-gray-400 uppercase tracking-widest mt-6 mb-4 px-2">Registration</p>
				    <a href="#" onclick="loadContent('new_product')" class="menu-item flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
				        <i class="fas fa-plus-circle w-5 group-hover:scale-110 transition-transform"></i>
				        <span class="font-bold">새 상품 등록</span>
				    </a>
				</nav>
            </div>
        </aside>

        <!-- 메인 컨텐츠 -->
        <main id="main-content" class="flex-1 content-scroll p-10 bg-gray-50">
            <div class="max-w-6xl mx-auto">
                <!-- 헤더 영역 -->
                <div class="flex items-end justify-between mb-10">
                    <div>
                        <h2 id="pageTitle" class="text-3xl font-black text-gray-900 bg-transparent leading-none">사용자 리스트</h2>
                        <p id="pageDesc" class="text-gray-500 mt-2 font-medium">시스템에 등록된 모든 사용자 정보를 관리합니다.</p>
                    </div>
                    <div id="topActionArea"></div>
                </div>

                <!-- 테이블 카드 -->
                <div class="bg-white rounded-[2rem] shadow-xl shadow-gray-200/50 border border-gray-100 overflow-hidden">
                    <table class="w-full text-left">
                        <thead class="bg-gray-50 border-b border-gray-100">
                            <tr id="tableHeaderRow">
                                <!-- JS에서 동적 생성 -->
                            </tr>
                        </thead>
                        <tbody id="listBody" class="divide-y divide-gray-50">
                            <!-- JSP 데이터 로드 영역 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

	<script>
		const config = {
				'user': {
			        title: '사용자 리스트',
			        desc: '시스템 권한별로 유저 정보를 관리합니다.',
			        path: '${pageContext.request.contextPath}/admin/user_list.do',
			        headers: ['아이디', '이름', '이메일', '권한', '가입일', '관리']
			    },
			    'product': {
			        title: '상품 리스트',
			        desc: '원산지, 제조사 등 상세 상품 정보를 관리합니다.',
			        path: '${pageContext.request.contextPath}/admin/product_list.do',
			        headers: ['상품명', '원산지', '제조사', '배전도', '가격', '재고량', '관리']
			    },
			    'review': {
			        title: '리뷰 관리',
			        desc: '고객들이 남긴 소중한 리뷰를 모니터링합니다.',
			        path: '${pageContext.request.contextPath}/admin/review_list.do',
			        headers: ['번호', '상품명', '작성자', '평점', '내용', '날짜', '관리']
			    },
			    'new_product': {
			        title: '새 상품 등록',
			        desc: '새로운 상품 정보를 입력하여 시스템에 등록합니다.',
			        path: '${pageContext.request.contextPath}/admin/product_form.do',
			        headers: [] // 폼 형태이므로 헤더가 필요 없음
			    }
	        };
		
		function loadContent(type) {
		    const cfg = config[type];
		    if (!cfg) return;

		    const colCount = cfg.headers.length;

		    // 1. UI 활성화 처리
		    document.querySelectorAll('.menu-item').forEach(el => el.classList.remove('active'));
		    // 클릭된 요소에 active 추가 (event 객체 사용 시 주의)
		    if(event) {
		        document.querySelectorAll('.menu-item').forEach(item => {
		            if(item.contains(event.target) || item === event.target) item.classList.add('active');
		        });
		    }

		    // 2. 제목 및 설명 업데이트
		    document.getElementById('pageTitle').textContent = cfg.title;
		    document.getElementById('pageDesc').textContent = cfg.desc;

		    // 3. 테이블 구조 제어 (새 상품 등록 같은 폼 페이지 처리)
		    const tableContainer = document.querySelector('.bg-white.rounded-\\[2rem\\]'); // 테이블 카드 div
		    const headerRow = document.getElementById('tableHeaderRow');
		    const listBody = document.getElementById('listBody');

		    if (cfg.headers.length === 0) {
		        // 헤더가 없으면 테이블 헤더 숨김 (등록 폼 페이지용)
		        headerRow.innerHTML = '';
		        listBody.innerHTML = `<tr><td class="py-20 text-center"><i class="fas fa-circle-notch fa-spin text-3xl text-blue-500 mb-4"></i></td></tr>`;
		    } else {
		        // 헤더 생성
		        headerRow.innerHTML = cfg.headers.map(text => {
		            let align = 'text-left';
		            if(['권한', '배전도', '평점', '번호'].includes(text)) align = 'text-center';
		            if(text === '관리') align = 'text-right';
		            return `<th class="px-6 py-5 text-xs font-black text-gray-400 uppercase tracking-widest ${align}">${text}</th>`;
		        }).join('');
		        
		        listBody.innerHTML = `<tr><td colspan="${colCount}" class="py-20 text-center"><i class="fas fa-circle-notch fa-spin text-3xl text-blue-500 mb-4"></i></td></tr>`;
		    }

		    // 4. 데이터 로드 (Fetch)
		    fetch(cfg.path)
		        .then(res => res.text())
		        .then(html => {
		        	if (type === 'new_product') {
		                // [팀원들이 만든 기존 틀 유지]
		                // 테이블의 모든 헤더를 비우고, tbody의 한 칸(td)에 본인의 JSP를 통째로 넣음
		                headerRow.innerHTML = ''; 
		                listBody.innerHTML = `<tr><td class="p-0 border-none">${html}</td></tr>`;
		            } else {
		                // [기존 팀원들의 리스트 로직]
		                listBody.innerHTML = html;
		            }
		        })
		        .catch(err => {
		            listBody.innerHTML = `<tr><td class="py-20 text-center text-red-500 font-bold">데이터를 가져오지 못했습니다.</td></tr>`;
		        });
		}

        // 초기 실행
        window.onload = () => loadContent('user');
    </script>

</body>
</html>