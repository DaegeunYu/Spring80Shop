<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="p-8 bg-white max-w-4xl mx-auto">
    <div class="mb-8 border-b border-gray-100 pb-4 flex justify-between items-end">
        <div>
            <h2 class="text-2xl font-black text-gray-800">사용자 상세 관리</h2>
            <p class="text-sm text-gray-500 mt-1">사용자 정보를 수정하고 권한을 관리합니다.</p>
        </div>
        <div class="flex gap-2">
            <span class="px-3 py-1 rounded-full text-xs font-bold bg-gray-100 text-gray-600">
                ${user.user_type == 'business' ? '법인회원' : '개인회원'}
            </span>
        </div>
    </div>

    <form id="userForm" action="${pageContext.request.contextPath}/users/updateUser.do" method="post" enctype="multipart/form-data" class="space-y-8">
        <input type="hidden" name="idx" value="${user.idx}">
        <input type="hidden" name="user_type" value="${user.user_type}">

        <div class="space-y-4">
            <h3 class="text-lg font-bold text-gray-800 flex items-center gap-2">
                <span class="w-1 h-5 bg-gray-800 rounded-full"></span> 기본 계정 정보
            </h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">아이디</label>
                    <input type="text" name="user_id" value="${user.user_id}" readonly class="w-full px-4 py-2 bg-gray-50 border border-gray-200 rounded-lg text-gray-400 cursor-not-allowed text-sm">
                </div>
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">회원 등급</label>
                    <select name="user_role" class="w-full px-4 py-2 border border-gray-200 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm bg-white">
                        <option value="member" ${user.user_role == 'member' ? 'selected' : ''}>일반 (member)</option>
                        <option value="vip" ${user.user_role == 'vip' ? 'selected' : ''}>VIP (vip)</option>
                        <option value="admin" ${user.user_role == 'admin' ? 'selected' : ''}>관리자 (admin)</option>
                    </select>
                </div>
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700 text-blue-600">새 비밀번호 (변경시에만 입력)</label>
                    <input type="password" name="user_pw" placeholder="변경할 비밀번호를 입력하세요" class="w-full px-4 py-2 border border-blue-100 bg-blue-50/30 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
                </div>
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">${user.user_type == 'business' ? '담당자명' : '이름'}</label>
                    <input type="text" name="user_name" value="${user.user_name}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pt-4">
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">이메일</label>
                <input type="email" name="user_email" value="${user.user_email}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
            </div>
            <div class="space-y-2">
                <label class="block text-sm font-bold text-gray-700">연락처</label>
                <input type="text" name="user_tel" value="${user.user_tel}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
            </div>
            <div class="md:col-span-2 space-y-2">
                <label class="block text-sm font-bold text-gray-700">주소 / 사업장 소재지</label>
                <input type="text" name="user_add" value="${user.user_add}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
            </div>
        </div>

        <c:choose>
            <%-- 법인 회원 전용 --%>
            <c:when test="${user.user_type == 'business'}">
                <div class="p-6 bg-amber-50/50 rounded-2xl border border-amber-100 space-y-4">
                    <h3 class="text-amber-800 font-bold text-sm flex items-center gap-2">
                        <span class="w-1.5 h-4 bg-amber-500 rounded-full"></span> 법인 사업자 상세 정보
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-gray-500">사업자 등록번호</label>
                            <input type="text" name="biz_reg_no" value="${user.biz_reg_no}" class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm">
                        </div>
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-gray-500">법인 상호명</label>
                            <input type="text" name="company_name" value="${user.company_name}" class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm">
                        </div>
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-gray-500">대표자명</label>
                            <input type="text" name="ceo_name" value="${user.ceo_name}" class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm">
                        </div>
                        <div class="space-y-1">
                            <label class="text-xs font-semibold text-gray-500">업태/유형</label>
                            <input type="text" name="biz_type" value="${user.biz_type}" class="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm">
                        </div>
                        <div class="md:col-span-2 space-y-2 pt-2">
                            <label class="text-xs font-semibold text-gray-500">사업자 등록증 재업로드</label>
                            <input type="file" name="upload_file" class="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-amber-100 file:text-amber-700 hover:file:bg-amber-200">
                            <c:if test="${not empty user.biz_license_file}">
                                <p class="text-xs text-gray-400 mt-1">기존 파일: <a href="${user.biz_license_file}" target="_blank" class="underline">${user.biz_license_file}</a></p>
                                <input type="hidden" name="biz_license_file" value="${user.biz_license_file}">
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:when>

            <%-- 개인 회원 전용 --%>
            <c:otherwise>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 border-t border-gray-100 pt-6">
                    <div class="space-y-2">
                        <label class="block text-sm font-bold text-gray-700">나이</label>
                        <input type="number" name="user_age" value="${user.user_age}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
                    </div>
                    <div class="space-y-2">
                        <label class="block text-sm font-bold text-gray-700">성별</label>
                        <div class="flex gap-4 p-2 bg-gray-50 rounded-lg border border-gray-200">
                            <label class="inline-flex items-center cursor-pointer ml-2">
                                <input type="radio" name="user_gender" value="M" ${user.user_gender != 'F' ? 'checked' : ''} class="w-4 h-4 text-blue-600">
                                <span class="ml-2 text-sm text-gray-600 font-medium">남성</span>
                            </label>
                            <label class="inline-flex items-center cursor-pointer">
                                <input type="radio" name="user_gender" value="F" ${user.user_gender == 'F' ? 'checked' : ''} class="w-4 h-4 text-blue-600">
                                <span class="ml-2 text-sm text-gray-600 font-medium">여성</span>
                            </label>
                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="block text-sm font-bold text-gray-700">생년월일</label>
                        <input type="date" name="user_birthday" value="${fn:substring(user.user_birthday, 0, 10)}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
                    </div>
                </div>
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">추천인 ID</label>
                    <input type="text" name="recommender_id" value="${user.recommender_id}" class="w-full px-4 py-2 border border-gray-300 rounded-lg text-sm">
                </div>
            </c:otherwise>
        </c:choose>

        <div class="pt-6">
            <button type="submit" class="w-full py-4 bg-blue-600 text-white font-black text-lg rounded-2xl hover:bg-blue-700 shadow-xl shadow-blue-100 transition-all active:scale-[0.98]">
                정보 업데이트 저장
            </button>
        </div>
    </form>
</div>