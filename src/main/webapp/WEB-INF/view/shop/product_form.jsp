<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="p-8 bg-white">
    <form id="productForm" action="${path}/product/insertProduct.do" method="post" enctype="multipart/form-data" class="space-y-6">
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">원두의 종류</label>
                <div class="flex items-center gap-4 p-2 bg-gray-50 rounded-lg">
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_single_origin" value="Y" checked class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">싱글 원두</span>
                    </label>
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_single_origin" value="N" class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">블렌딩 원두</span>
                    </label>
                </div>
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">디카페인 여부</label>
                <div class="flex items-center gap-4 p-2 bg-gray-50 rounded-lg">
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_decafe" value="N" checked class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">카페인</span>
                    </label>
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_decafe" value="Y" class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">디카페인</span>
                    </label>
                </div>
            </div>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-bold text-gray-700">상품명</label>
            <input type="text" name="product_name" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none transition-all" placeholder="최대 80자 이내로 입력해주세요" maxlength="80">
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-bold text-gray-700">대표이미지</label>
            <input type="file" name="product_img_file" class="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100">
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">원산지</label>
                <input type="text" name="origin" maxlength="20" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">브랜드</label>
                <input type="text" name="brand" maxlength="20" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">볶음도</label>
                <input type="text" name="roast_dgree" maxlength="10" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 border-t border-gray-50 pt-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">제조사</label>
                <input type="text" name="manufacturing" maxlength="20" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">판매가</label>
                <input type="text" name="origin_price" maxlength="10" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">할인가</label>
                <input type="text" name="sale_price" maxlength="10" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
        </div>

        <div class="border-t border-gray-100 pt-6">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-md font-bold text-gray-800 italic">Product Options</h3>
                <button type="button" onclick="addOption()" class="px-4 py-2 bg-gray-900 text-white text-xs font-bold rounded-lg hover:bg-gray-800 transition-all flex items-center gap-2">
                    <i class="fas fa-plus"></i> 옵션 추가
                </button>
            </div>
            <div id="option_container" class="space-y-3">
                </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 border-t border-gray-50 pt-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">보유량(g)</label>
                <input type="text" name="quantity" maxlength="10" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">상품 출시일</label>
                <input type="date" name="release_date" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm text-gray-600">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">유통기한</label>
                <input type="date" name="expiration_date" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm text-gray-600">
            </div>
        </div>

        <div class="pt-10">
            <button type="submit" class="w-full py-4 bg-blue-600 text-white font-black text-lg rounded-2xl hover:bg-blue-700 shadow-xl shadow-blue-100 transition-all active:scale-[0.98]">
                상품 정보 저장하기
            </button>
        </div>
    </form>
</div>

<script>
    // 페이지 로드 시 첫 번째 옵션 자동 생성
    (function() {
        addOption();
    })();

    function addOption() {
        const container = document.getElementById('option_container');
        const newOption = document.createElement('div');
        newOption.className = 'option-item flex gap-3 items-center bg-gray-50 p-3 rounded-xl border border-gray-100 animate-fadeIn';
        
        newOption.innerHTML = `
            <div class="flex-1">
                <select class="opt-weight w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white outline-none focus:border-blue-400">
                    <option value="200g">200g</option>
                    <option value="350g">350g</option>
                    <option value="500g">500g</option>
                    <option value="1kg">1kg</option>
                </select>
            </div>
            <div class="flex-1">
                <input type="text" class="opt-price w-full px-3 py-2 border border-gray-200 rounded-lg text-sm bg-white outline-none focus:border-blue-400" placeholder="옵션 가격(숫자만)">
            </div>
            <button type="button" onclick="removeOption(this)" class="w-10 h-10 flex items-center justify-center text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-all">
                <i class="fas fa-trash-can"></i>
            </button>
        `;
        
        container.appendChild(newOption);
        reIndexOptions();
    }

    function removeOption(btn) {
        const items = document.querySelectorAll('.option-item');
        if(items.length > 1) {
            btn.closest('.option-item').remove();
            reIndexOptions();
        } else {
            alert('최소 하나 이상의 옵션은 존재해야 합니다.');
        }
    }

    function reIndexOptions() {
        const items = document.querySelectorAll('#option_container .option-item');
        items.forEach((item, idx) => {
            const select = item.querySelector('.opt-weight');
            const input = item.querySelector('.opt-price');
            
            if(select) select.name = "optionList[" + idx + "].product_weight";
            if(input) input.name = "optionList[" + idx + "].product_price";
        });
    }

    // 전송 전 최종 점검
    document.getElementById('productForm').onsubmit = function() {
        reIndexOptions();
        // 간단한 유효성 검사 예시 (상품명 필수 등)
        const pName = this.product_name.value.trim();
        if(!pName) {
            alert('상품명을 입력해주세요.');
            this.product_name.focus();
            return false;
        }
        return true;
    };
</script>

<style>
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .animate-fadeIn {
        animation: fadeIn 0.3s ease-out forwards;
    }
</style>