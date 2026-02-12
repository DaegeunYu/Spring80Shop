<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="p-8 bg-white max-w-4xl mx-auto">
    <div class="mb-8 border-b border-gray-100 pb-4 flex justify-between items-end">
        <div>
            <h2 class="text-2xl font-black text-gray-800">사용자 상세 관리</h2>
            <p class="text-sm text-gray-500 mt-1">회원 등급 및 상세 프로필 정보를 수정합니다.</p>
        </div>
        <span class="px-3 py-1 rounded-full text-xs font-bold ${user.user_role == 'admin' ? 'bg-purple-100 text-purple-700' : user.user_role == 'business' ? 'bg-amber-100 text-amber-700' : 'bg-blue-100 text-blue-700'}">
            ${user.user_role == 'admin' ? '관리자' : user.user_role == 'business' ? '법인회원' : '일반회원'}
        </span>
    </div>

    <form id="userForm" action="${pageContext.request.contextPath}/admin/updateUser.do" method="post" class="space-y-6">
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">아이디</label>
                <input type="text" name="user_id" value="${user.user_id}" readonly class="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-lg text-gray-500 cursor-not-allowed outline-none text-sm">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">회원 등급</label>
                <select name="user_role" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm bg-white">
                    <option value="member" ${user.user_role == 'member' ? 'selected' : ''}>일반 회원 (member)</option>
                    <option value="business" ${user.user_role == 'business' ? 'selected' : ''}>법인 회원 (business)</option>
                    <option value="admin" ${user.user_role == 'admin' ? 'selected' : ''}>관리자 (admin)</option>
                </select>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4">
            <div class="space-y-2">
            	<label id="nameLabel" class="block text-sm font-bold text-gray-700">${user.user_role == 'business' ? '법인 상호명' : '이름'}</label>
                <input type="text" name="user_name" value="${user.user_name}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none transition-all text-sm">
            </div>
            <div class="space-y-2">
			    <label class="block text-sm font-bold text-gray-700">성별</label>
			    <div id="gender_container" class="flex items-center gap-4 p-1.5 rounded-lg ${user.user_role == 'business' ? 'bg-gray-100 opacity-60' : 'bg-gray-50'}">
			        
			        <span id="business_only_msg" class="text-xs text-gray-400 px-2 italic ${user.user_role == 'business' ? '' : 'hidden'}">
			            법인 회원은 해당 없음
			        </span>
			
			        <div id="gender_radio_group" class="flex gap-4 ${user.user_role == 'business' ? 'hidden' : ''}">
			            <label class="inline-flex items-center cursor-pointer ml-2">
			                <input type="radio" name="user_gender" value="M" ${user.user_gender == 'F' ? '' : 'checked'} 
			                       ${user.user_role == 'business' ? 'disabled' : ''} class="w-4 h-4 text-blue-600">
			                <span class="ml-2 text-sm">남성</span>
			            </label>
			            <label class="inline-flex items-center cursor-pointer ml-2">
			                <input type="radio" name="user_gender" value="F" ${user.user_gender == 'F' ? 'checked' : ''} 
			                       ${user.user_role == 'business' ? 'disabled' : ''} class="w-4 h-4 text-blue-600">
			                <span class="ml-2 text-sm">여성</span>
			            </label>
			        </div>
			        
			    </div>
			</div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">이메일</label>
                <input type="email" name="user_email" value="${user.user_email}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">전화번호</label>
                <input type="text" name="user_tel" value="${user.user_tel}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
            </div>
        </div>

        <div class="space-y-2">
            <label class="block text-sm font-bold text-gray-700">주소 / 사업장 소재지</label>
            <input type="text" name="user_add" value="${user.user_add}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 border-t border-gray-50 pt-6">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">나이</label>
                <input type="number" id="input_age" name="user_age" value="${user.user_age}" ${user.user_role == 'business' ? 'readonly' : ''} class="w-full px-4 py-2 border border-gray-200 rounded-lg outline-none text-sm ${user.user_role == 'business' ? 'bg-gray-100 text-gray-400' : ''}">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">생년월일</label>
                <input type="date" id="input_birthday" name="user_birthday" value="${fn:substring(user.user_birthday, 0, 10)}" ${user.user_role == 'business' ? 'readonly' : ''} class="w-full px-4 py-2 border border-gray-200 rounded-lg outline-none text-sm ${user.user_role == 'business' ? 'bg-gray-100 text-gray-400' : ''}">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">추천인 ID</label>
                <input type="text" id="input_recommender" name="recommender_id" value="${user.recommender_id}" ${user.user_role == 'business' ? 'readonly' : ''} class="w-full px-4 py-2 border border-gray-200 rounded-lg outline-none text-sm ${user.user_role == 'business' ? 'bg-gray-100 text-gray-400' : ''}">
            </div>
        </div>

        <div class="pt-10 flex gap-4">
            <button type="submit" class="flex-[2] py-4 bg-blue-600 text-white font-black text-lg rounded-2xl hover:bg-blue-700 shadow-xl shadow-blue-100 transition-all active:scale-[0.98]">
                사용자 정보 업데이트
            </button>
        </div>
    </form>
</div>