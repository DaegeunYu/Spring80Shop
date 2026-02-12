<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="formDataContainer" style="display:none;">
	<input type="hidden" id="mode" value="${mode}">
	<c:forEach var="opt" items="${product.optionList}" varStatus="status">
	    <div class="option-item-group">
	    	<input type="hidden" class="opt-code" data-idx="${status.index}" value="${opt.product_code}">
	        <input type="hidden" class="opt-weight" data-idx="${status.index}" value="${opt.product_weight}">
	        <input type="hidden" class="opt-price" data-idx="${status.index}" value="${opt.product_price}">
	    </div>
	</c:forEach>
</div>

<div class="p-8 bg-white">
    <form id="productForm" action="${pageContext.request.contextPath}/admin/${mode == 'edit' ? 'changeProduct.do' : 'insertProduct.do'}" method="post" enctype="multipart/form-data" class="space-y-6">
        <input type="hidden" name="product_code" value="${product.product_code}">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">원두의 종류</label>
                <div class="flex items-center gap-4 p-2 bg-gray-50 rounded-lg">
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_single_origin" value="Y" ${product.is_single_origin == 'n' ? '' : 'checked'} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">싱글 원두</span>
                    </label>
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_single_origin" value="N" ${product.is_single_origin == 'n' ? 'checked' : ''} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">블렌딩 원두</span>
                    </label>
                </div>
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">디카페인 여부</label>
                <div class="flex items-center gap-4 p-2 bg-gray-50 rounded-lg">
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_decafe" value="N" ${product.is_decafe == 'y' ? '' : 'checked'} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">카페인</span>
                    </label>
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="is_decafe" value="Y" ${product.is_decafe == 'y' ? 'checked' : ''} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">디카페인</span>
                    </label>
                </div>
            </div>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-bold text-gray-700">상품명</label>
            <input type="text" name="product_name" placeholder="최대 80자 이내로 입력해주세요" maxlength="80" value="${product.product_name}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none transition-all">
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-bold text-gray-700">대표이미지</label>
            <input type="file" name="product_img_file" class="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100">
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">원산지</label>
                <input type="text" name="origin" maxlength="20" value="${product.origin}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">브랜드</label>
                <input type="text" name="brand" maxlength="20" value="${product.brand}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">볶음도</label>
                <div class="flex items-center gap-4 p-2 bg-gray-50 rounded-lg">
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="roast_dgree" value="S" ${product.roast_dgree == '약배전' ? '' : product.roast_dgree == '중배전' ? '' : 'checked'} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">강배전</span>
                    </label>
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="roast_dgree" value="M" ${product.roast_dgree == '중배전' ? 'checked' : ''} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">중배전</span>
                    </label>
                    <label class="inline-flex items-center cursor-pointer">
                        <input type="radio" name="roast_dgree" value="W" ${product.roast_dgree == '약배전' ? 'checked' : ''} class="w-4 h-4 text-blue-600">
                        <span class="ml-2 text-sm">약배전</span>
                    </label>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 border-t border-gray-50 pt-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">제조사</label>
                <input type="text" name="manufacturing" maxlength="20" value="${product.manufacturing}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">판매가</label>
                <input type="text" name="origin_price" maxlength="10" value="${product.origin_price}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">할인가</label>
                <input type="text" name="sale_price" maxlength="10" value="${product.sale_price}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
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
                <input type="text" name="quantity" maxlength="10" value="${product.quantity}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">상품 출시일</label>
                <input type="date" name="release_date" value="${fn:substring(product.release_date, 0, 10)}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm text-gray-600">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">유통기한</label>
                <input type="date" name="expiration_date" value="${fn:substring(product.expiration_date, 0, 10)}" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm text-gray-600">
            </div>
        </div>

        <div class="pt-10">
            <button type="submit" class="w-full py-4 bg-blue-600 text-white font-black text-lg rounded-2xl hover:bg-blue-700 shadow-xl shadow-blue-100 transition-all active:scale-[0.98]">
                상품 정보 저장하기
            </button>
        </div>
    </form>
</div>


<style>
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .animate-fadeIn {
        animation: fadeIn 0.3s ease-out forwards;
    }
</style>