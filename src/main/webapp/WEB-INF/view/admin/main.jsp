<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="UTF-8">

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 차트 실행 -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script> <!-- 차트 실행 -->

<title>관리자 페이지</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet">
</head>
<body class="overflow-hidden">

	<!-- 상단 네비게이션 바 -->
    <header class="h-16 bg-white border-b border-gray-200 shadow-sm flex items-center justify-between px-6 z-10 relative">
	    <div class="flex items-center gap-3">
	        <div class="w-10 h-10 rounded-lg overflow-hidden flex items-center justify-center bg-gray-50 border border-gray-100 shadow-sm">
	            <img src="${pageContext.request.contextPath}/resources/files/common/logo.jpg" alt="Logo" class="w-full h-full object-cover">
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
				    
				    <a href="#" onclick="loadContent('order_approval', this)" class="menu-item flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
       	 				<i class="fas fa-file-invoice-dollar w-5 group-hover:scale-110 transition-transform"></i>
        				<span class="font-bold">입금 승인 관리</span>
    				</a>
				    
					<a href="#" onclick="loadContent('sales')" class="menu-item flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
    					<i class="fas fa-chart-line w-5 group-hover:scale-110 transition-transform"></i>
    					<span class="font-bold">매출 현황</span>
					</a>
					
					<a href="#" onclick="loadContent('product_stats')" class="menu-item flex items-center gap-3 px-4 py-3 text-gray-600 rounded-xl transition-all hover:bg-gray-50 group">
    					<i class="fas fa-chart-pie w-5 group-hover:scale-110 transition-transform"></i>
    					<span class="font-bold">상품 판매 분석</span>
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
                <div id="dynamic-render-area" class="bg-white rounded-[2rem] shadow-xl shadow-gray-200/50 border border-gray-100 overflow-hidden p-4">
                    <table id="adminTable" class="w-full text-left">
                        <thead class="bg-gray-50 border-b border-gray-100 sticky top-0 z-20">
                            <tr id="tableHeaderRow" class="min-h-[60px]">
                            	<!-- JS 동적 생성 -->
                            </tr>
                        </thead>
                        <tbody id="listBody" class="divide-y divide-gray-50">
                            <!-- JSP 데이터 로드 영역 -->
                        </tbody>
                    </table>
                    <div id="formContainer" class="hidden min-h-[400px]"></div>
                </div>
            </div>
        </main>
    </div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
			        headers: [], // 폼 형태이므로 헤더가 필요 없음
			        isForm: true
			    },
			    'change_product': {
			        title: '상품 수정',
			        desc: '상품 정보를 수정하여 시스템에 등록합니다.',
			        path: '${pageContext.request.contextPath}/admin/product_form.do',
			        headers: [], // 폼 형태이므로 헤더가 필요 없음
			        isForm: true
			    },
			    'change_user': {
			        title: '사용자 정보 수정',
			        desc: '사용자 정보를 수정하여 시스템에 등록합니다.',
			        path: '${pageContext.request.contextPath}/admin/user_form.do',
			        headers: [], // 폼 형태이므로 헤더가 필요 없음
			        isForm: true
			    },
			    'sales': {
			        title: '매출 현황',
			        desc: '결제 완료된 제품의 매출과 주문정보를 분석 합니다.',
			        path: '${pageContext.request.contextPath}/admin/sales_list.do',
			        headers: []
			    },
			    'product_stats': {
			        title: '상품 판매 분석',
			        desc: '상품별 점유율과 판매량 무게별 판매 추이를 분석합니다.',
			        path: '${pageContext.request.contextPath}/admin/product_sales.do',
			        headers: []
			    },
			    'order_approval': {
			        title: '입금 승인 관리',
			        desc: '계좌이체 주문의 입금 여부를 확인하고 승인 처리합니다.',
			        path: '${pageContext.request.contextPath}/admin/order_approval.do',
			        headers: []
			    }
			    
	        };
		
		async function loadContent(type, element) {
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
		    fetchData(cfg.path, element);
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
		    const adminTable = document.getElementById('adminTable'); // 여기서 adminTable로 가져옴
		    const formContainer = document.getElementById('formContainer');
		    
		    const type = Object.keys(config).find(key => path.includes(config[key].path));
		    const cfg = config[type];
		    
		    if (!listBody) return;

		    // 로딩 표시
		    listBody.innerHTML = `<tr><td colspan="10" class="py-20 text-center"><i class="fas fa-circle-notch fa-spin text-3xl text-blue-500"></i></td></tr>`;

		    fetch(path)
		        .then(res => res.text())
		        .then(html => {
		            if (cfg && cfg.isForm) {
		            	adminTable.classList.add('hidden');
		                formContainer.classList.remove('hidden');
		                formContainer.innerHTML = html;
		                targetArea = formContainer; // 폼 컨테이너에서 스크립트 찾기
		                
		                setTimeout(() => {
		                    const container = document.getElementById('option_container');
		                    if (container && container.children.length === 0) {
		                        const addBtn = document.querySelector('button[onclick="addOption()"]');
		                        if (addBtn) addBtn.click();
		                    }
		                }, 100);
		            } else {
		            	adminTable.classList.remove('hidden');       
		                formContainer.classList.add('hidden');
		                listBody.innerHTML = html;
		                targetArea = listBody; // 리스트 본문에서 스크립트 찾기
		                
		             	// 삽입된 HTML 내의 스크립트를 추출하여 강제 실행 
		                const scripts = targetArea.querySelectorAll("script");
		                scripts.forEach(oldScript => {
		                    const newScript = document.createElement("script");
		                    // 기존 스크립트의 모든 속성 복사 (src, type 등)
		                    Array.from(oldScript.attributes).forEach(attr => 
		                        newScript.setAttribute(attr.name, attr.value)
		                    );
		                    // 스크립트 내부의 텍스트 코드 복사 (차트 생성 로직 등)
		                    newScript.appendChild(document.createTextNode(oldScript.innerHTML));
		                    // 노드를 교체하여 브라우저가 스크립트를 즉시 실행하게 함
		                    oldScript.parentNode.replaceChild(newScript, oldScript);
		                });
		                
		            }
		        })
		        .catch(err => {
		            console.error("데이터 로드 실패:", err);
		            listBody.innerHTML = `<tr><td colspan="10" class="py-20 text-center text-red-500 font-bold">데이터를 로드하는 중 오류가 발생했습니다.</td></tr>`;
		        });
		}
		// formContainer 내부의 클릭 이벤트 감시
		document.getElementById('formContainer').addEventListener('click', function(e) {
		    // 1. [수정] id="addOption" 버튼 클릭 시 (closest를 써서 아이콘 클릭도 인식)
		    if (e.target && e.target.closest('button[onclick="addOption()"]')) {
		        e.preventDefault(); // 기본 동작 방지
		        
		        // [수정] product_form.jsp에 적힌 id와 동일하게 맞춤
		        const container = document.getElementById('option_container');
		       
		        const mode = document.getElementById("mode").value;
		        const options = getProductOptions();
		        
		        if (mode === "edit") {
		        	options.forEach((el, index) => {
		        		makeOption(container, options[index].weight, options[index].price)
		            });
                } else {
                    makeOption(container, "200g", "")
                }
		        
		    }

		    // 2. 삭제 버튼 클릭 시
		    if (e.target && e.target.closest('.remove-btn')) {
		        const items = document.querySelectorAll('.option-item');
		        if(items.length > 1) {
		            e.target.closest('.option-item').remove();
		            // 재인덱싱 (필요 시 호출)
		            const allItems = document.querySelectorAll('#option_container .option-item');
		            allItems.forEach((item, i) => {
		                item.querySelector('.opt-weight').name = `optionList[\${i}].product_weight`;
		                item.querySelector('.opt-price').name = `optionList[\${i}].product_price`;
		            });
		        } else {
		            alert('최소 하나 이상의 옵션은 존재해야 합니다.');
		        }
		    }
		});
		// 2. [추가된 부분] formContainer 내부의 전송(submit) 이벤트 관리
		document.getElementById('formContainer').addEventListener('submit', function(e) {
		    if (e.target && e.target.id === 'productForm') {
		        // [중요] 일단 브라우저의 기본 이동(404 에러 원인)을 무조건 막습니다.
		        e.preventDefault(); 
		
		        // 1. 유효성 검증 (기존 pName 로직 유지)
		        const pName = e.target.product_name.value.trim();
		        if (!pName) {
		            alert('상품명을 입력해주세요.');
		            e.target.product_name.focus();
		            return; // 여기서 중단
		        }
		        
		        const mode = document.getElementById("mode").value;
		        let message = '상품 등록이 완료되었습니다!';
		        if (mode === "edit") {
		        	message = '상품 수정이 완료되었습니다!';
		        }
		        
		        // 2. 비동기(AJAX) 전송 로직 시작
		        // FormData는 input type="file"을 포함한 모든 데이터를 자동으로 묶어줍니다.
		        const formData = new FormData(e.target);
		        
		        // e.target.action은 form 태그에 적힌 주소(${path}/product/insertProduct.do)를 가져옵니다.
		        fetch(e.target.action, {
		            method: 'POST',
		            body: formData
		        })
		        .then(res => {
		            if (!res.ok) throw new Error('전송 실패');
		            // 서버에서 저장 후 성공 문자열이나 JSON을 보낸다고 가정
		            return res.text(); 
		        })
		        .then(data => {
		            alert(message);
		            loadContent('product'); // 성공 후 리스트 화면으로 자동 전환 (새로고침 없이!)
		        })
		        .catch(err => {
		            console.error(err);
		            alert('저장 중 오류가 발생했습니다. 컨트롤러 주소를 확인해주세요.');
		        });
		    }
		});
		// user_form 제출 처리
		document.addEventListener('submit', function(e) {
		    if (e.target && e.target.id === 'userForm') {
		        e.preventDefault();
		
		        if(!confirm("정보를 수정하시겠습니까?")) return;
		
		        const form = e.target;
		        const formData = new FormData(form); // 파일 데이터를 포함하여 생성
		        const url = form.action;
		
		        // 개인회원 나이값 빈값일 때 보정 (Integer 에러 방지)
		        const userType = formData.get('user_type');
		        if (userType === 'personal' && !formData.get('user_age')) {
		            formData.set('user_age', '0');
		        }
		
		        fetch(url, {
		            method: 'POST',
		            body: formData // URLSearchParams가 아닌 FormData 객체 그대로 전달
		        })
		        .then(response => response.text())
		        .then(data => {
		            if (data.trim() === "success") {
		                alert("성공적으로 업데이트되었습니다.");
		                if(typeof loadContent === 'function') {
		                    loadContent('user');
		                } else {
		                    location.reload();
		                }
		            } else {
		                alert("수정 실패: " + data);
		            }
		        })
		        .catch(error => {
		            console.error('Error:', error);
		            alert("서버 통신 중 오류가 발생했습니다.");
		        });
		    }
		});
        // 초기 실행
        window.onload = () => loadContent('user');
        
        function getProductOptions() {
        	const codes = document.querySelectorAll('.opt-code');
            const weights = document.querySelectorAll('.opt-weight');
            const prices = document.querySelectorAll('.opt-price');
            
            let optionList = [];

            // 인덱스를 기준으로 데이터를 매칭하여 객체 생성
            weights.forEach((el, index) => {
                let optionObj = {
                	code: codes[index].value,
                    weight: weights[index].value,
                    price: prices[index].value
                };
                optionList.push(optionObj);
            });

            return optionList;
        }
        
        function makeOption(container, weight, price) {
        	if (!container) return;

	        const idx = container.querySelectorAll('.option-item').length;
	        const newOption = document.createElement('div');
	        newOption.className = 'option-item flex gap-3 items-center bg-gray-50 p-3 rounded-xl border border-gray-100 animate-fadeIn';
	        
	        // product_form.jsp의 원본 디자인 유지
	        newOption.innerHTML = `
	            <div class="flex-1">
	                <select name="optionList[\${idx}].product_weight" class="opt-weight w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white outline-none focus:border-blue-400">
	                    <option value="200g">200g</option>
	                    <option value="350g">350g</option>
	                    <option value="500g">500g</option>
	                    <option value="1000g">1kg</option>
	                </select>
	            </div>
	            <div class="flex-1">
	                <input type="text" name="optionList[\${idx}].product_price" class="opt-price w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white outline-none focus:border-blue-400" placeholder="옵션 가격(숫자만)">
	            </div>
	            <button type="button" class="remove-btn w-10 h-10 flex items-center justify-center text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all">
	                <i class="fas fa-trash-can"></i>
	            </button>
	        `;
	        
	        const option_weight = newOption.querySelector('.opt-weight');
	        const option_price = newOption.querySelector('.opt-price');
	        
	        option_weight.value = weight;
	        option_price.value = price;
	        
	        container.appendChild(newOption);
        }
        
        function changeProductInfo(product_code) {
        	config['change_product'].path = '${pageContext.request.contextPath}/admin/product_form.do?product_code='+product_code;
        	loadContent('change_product');
        }
        
        function changeUserInfo(user_id) {
        	config['change_user'].path = '${pageContext.request.contextPath}/admin/user_form.do?user_id='+user_id;
        	loadContent('change_user');
        }
        
        function deleteProduct(product_code) {
        	if (!confirm("정말 이 상품을 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
                return; // 사용자가 '취소'를 누르면 중단
            }
        	
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/deleteProduct.do",
                type: "POST", // 데이터 삭제/수정은 POST 방식이 안전합니다.
                data: { "product_code": product_code },
                success: function(response) {
                    if (response === "success") {
                        alert("상품이 정상적으로 삭제되었습니다.");
                        // 팝업창에서 삭제했다면 부모창 새로고침 후 팝업 닫기
                        if (window.opener) {
                            window.opener.loadContent('product');; 
                            window.close();
                        } else {
                        	loadContent('product');
                        }
                    } else {
                        alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
                    }
                },
                error: function() {
                    alert("서버 통신 중 오류가 발생했습니다.");
                }
            });
    	}
        
        function deleteUser(user_id) {
        	if (!confirm("정말 이 사용자를 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
                return; // 사용자가 '취소'를 누르면 중단
            }
        	
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/deleteUser.do",
                type: "POST", // 데이터 삭제/수정은 POST 방식이 안전합니다.
                data: { "user_id": user_id },
                success: function(response) {
                    if (response === "success") {
                        alert("사용자가 정상적으로 삭제되었습니다.");
                        // 팝업창에서 삭제했다면 부모창 새로고침 후 팝업 닫기
                        if (window.opener) {
                            window.opener.loadContent('user');; 
                            window.close();
                        } else {
                        	loadContent('user');
                        }
                    } else {
                        alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
                    }
                },
                error: function() {
                    alert("서버 통신 중 오류가 발생했습니다.");
                }
            });
    	}
        
        function viewReviewDetail(idx) {
    	    const url = "${pageContext.request.contextPath}/review/reviewDetail.do?idx=" + idx;
    	    const options = "width=700, height=800, top=100, left=200, resizable=yes, scrollbars=yes";
    	    window.open(url, "ReviewDetail_" + idx, options);
    	}
        
        function deleteReview(idx) {
        	if (!confirm("정말 이 리뷰를 삭제하시겠습니까?\n삭제 후에는 복구할 수 없습니다.")) {
                return; // 사용자가 '취소'를 누르면 중단
            }
        	
            $.ajax({
                url: "${pageContext.request.contextPath}/review/deleteReview.do",
                type: "POST", // 데이터 삭제/수정은 POST 방식이 안전합니다.
                data: { "idx": idx },
                success: function(response) {
                    if (response === "success") {
                        alert("리뷰가 정상적으로 삭제되었습니다.");
                        // 팝업창에서 삭제했다면 부모창 새로고침 후 팝업 닫기
                        if (window.opener) {
                            window.opener.loadContent('review');; 
                            window.close();
                        } else {
                        	loadContent('review');
                        }
                    } else {
                        alert("삭제 실패: 권한이 없거나 오류가 발생했습니다.");
                    }
                },
                error: function() {
                    alert("서버 통신 중 오류가 발생했습니다.");
                }
            });
    	}
    </script>

</body>
</html>