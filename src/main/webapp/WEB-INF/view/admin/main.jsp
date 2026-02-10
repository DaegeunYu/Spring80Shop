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
                <div class="flex justify-between items-end mb-8">
				    <div>
				        <h1 id="pageTitle" class="text-3xl font-black text-gray-900 mb-2"></h1>
				        <p id="pageDesc" class="text-gray-400 font-medium"></p>
				    </div>
				    <div id="filterArea" class="flex gap-3"></div>
				</div>

                <!-- 테이블 카드 -->
                <div class="bg-white rounded-[2rem] shadow-xl shadow-gray-200/50 border border-gray-100 overflow-hidden">
                    <table class="w-full text-left">
                        <thead class="bg-gray-50 border-b border-gray-100 sticky top-0 z-20">
                            <tr id="tableHeaderRow" class="min-h-[60px]">
                            	<!-- JS 동적 생성 -->
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
			        headers: ['아이디', '이름', '이메일', '권한', '가입일', '관리'],
			        filters: [
			            { id: 'roleFilter', label: '전체 선택', options: ['전체', 'admin', 'business', 'member'] }
			        ]
			    },
			    'product': {
			        title: '상품 리스트',
			        desc: '원산지, 제조사 등 상세 상품 정보를 관리합니다.',
			        path: '${pageContext.request.contextPath}/admin/product_list.do',
			        headers: ['상품명', '원산지', '제조사', '배전도', '가격', '재고량', '관리'],
			        filters: [
			            { id: 'companyFilter', label: '전체 선택', options: ['전체', 'KBS', 'SBS', 'MBC'] }
			        ]
			    },
			    'review': {
			        title: '리뷰 관리',
			        desc: '고객들이 남긴 소중한 리뷰를 모니터링합니다.',
			        path: '${pageContext.request.contextPath}/admin/review_list.do',
			        headers: ['작성자ID', '작성자 이름', '상품코드', '제목', '평점', '날짜', '관리']
			    },
			    'new_product': {
			        title: '새 상품 등록',
			        desc: '새로운 상품 정보를 입력하여 시스템에 등록합니다.',
			        path: '${pageContext.request.contextPath}/admin/product_form.do',
			        headers: [] // 폼 형태이므로 헤더가 필요 없음
			    }
	        };
		
		async function loadContent(type, element) {
		    console.log(">>> loadContent 호출됨! 타입:", type);
		    const cfg = config[type];
		    if (!cfg) return;

		    // 1. UI 활성화 처리 (메뉴 강조)
		    document.querySelectorAll('.menu-item').forEach(el => el.classList.remove('active'));
		    if (element) {
		        element.classList.add('active');
		    }

		    // 2. 제목 및 설명 업데이트
		    document.getElementById('pageTitle').textContent = cfg.title;
		    document.getElementById('pageDesc').textContent = cfg.desc;

		    // 3. 필터 영역 생성 (우측 상단)
		    const filterArea = document.getElementById('filterArea');
		    if (filterArea) {
		        filterArea.innerHTML = ''; // 기존 필터 제거
		        await setupFilters(type, filterArea); // 동적 필터 생성 호출
		    }

		    // 4. 테이블 헤더 생성
		    const headerRow = document.getElementById('tableHeaderRow');
		    if (headerRow) {
		        const colCount = cfg.headers.length;
		        if (colCount === 0) {
		            headerRow.innerHTML = '';
		        } else {
		            headerRow.innerHTML = cfg.headers.map(text => {
		                let align = 'text-center'; // 기본 중앙 정렬
		                if (['내용', '상품명'].includes(text)) align = 'text-left';
		                if (text === '관리') align = 'text-right';
		                
		                // JSP 충돌 방지를 위해 \${text} 사용
		                return `<th class="px-6 py-5 text-xs font-bold text-gray-900 uppercase tracking-widest \${align} bg-gray-50">
		                            \${text}
		                        </th>`;
		            }).join('');
		        }
		    }

		    // 5. 초기 데이터 로드 (필터 없이 전체 데이터)
		    fetchData(cfg.path);
		}

		/**
		 * 필터를 동적으로 생성하는 함수
		 */
		async function setupFilters(type, filterArea) {
		    const cfg = config[type];
		    if (!cfg.filters) return;

		    for (const filter of cfg.filters) {
		        const select = document.createElement('select');
		        select.id = filter.id;
		        select.className = "px-4 py-2 rounded-xl border border-gray-200 text-sm font-bold text-gray-600 outline-none focus:border-blue-500 transition-all cursor-pointer bg-white shadow-sm hover:bg-gray-50";
		        
		        // 기본 선택 옵션 (전체)
		        const defaultOpt = document.createElement('option');
		        defaultOpt.value = "";
		        defaultOpt.textContent = filter.label;
		        select.appendChild(defaultOpt);

		        // [동적 데이터 로드] 상품 관리의 제조사 필터인 경우
		        if (type === 'product' && filter.id === 'companyFilter') {
		            try {
		                const response = await fetch('${pageContext.request.contextPath}/admin/getManufacturing.do');
		                const companies = await response.json();
		                companies.forEach(manufacturing => {
		                    const option = document.createElement('option');
		                    option.value = manufacturing;
		                    option.textContent = manufacturing;
		                    select.appendChild(option);
		                });
		            } catch (err) {
		                console.warn("제조사 목록 로드 실패 (DB 확인 필요):", err);
		            }
		        } 
		        // [정적 데이터 로드] 사용자 관리 권한 등
		        else if (filter.options) {
		            filter.options.forEach(opt => {
		                if (opt === '전체') return;
		                const option = document.createElement('option');
		                option.value = opt;
		                option.textContent = opt;
		                select.appendChild(option);
		            });
		        }

		        // 필터 변경 이벤트
		        select.onchange = () => {
		            const paramName = (type === 'user') ? 'role' : 'manufacturing';
		            // 파라미터가 비어있지 않으면 쿼리스트링 생성
		            const finalPath = select.value 
		                ? `\${cfg.path}?\${paramName}=\${encodeURIComponent(select.value)}`
		                : cfg.path;
		                
	                console.log(">>> 요청 보내는 경로:", finalPath);
		            fetchData(finalPath);
		        };

		        filterArea.appendChild(select);
		    }
		}

		/**
		 * 서버에서 데이터를 가져와 tbody를 갱신하는 함수
		 */
		function fetchData(path) {
		    const listBody = document.getElementById('listBody');
		    if (!listBody) return;

		    // 로딩 표시
		    listBody.innerHTML = `<tr><td colspan="10" class="py-20 text-center"><i class="fas fa-circle-notch fa-spin text-3xl text-blue-500"></i></td></tr>`;

		    fetch(path)
		        .then(res => {
		            if (!res.ok) throw new Error("서버 응답 오류");
		            return res.text();
		        })
		        .then(html => {
		            listBody.innerHTML = html;
		        })
		        .catch(err => {
		            console.error("데이터 로드 실패:", err);
		            listBody.innerHTML = `<tr><td colspan="10" class="py-20 text-center text-red-500 font-bold">데이터를 로드하는 중 오류가 발생했습니다.</td></tr>`;
		        });
		}
		
        // 초기 실행
        window.onload = () => loadContent('user');
    </script>

</body>
</html>