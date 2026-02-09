<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="user" items="${userList}">
    <tr class="hover:bg-gray-50/50 transition-colors group">
        <td class="px-6 py-4">
            <div class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full flex items-center justify-center font-bold text-xs
    				${user.user_role == 'admin' ? 'bg-red-50 text-red-500' : 'bg-blue-50 text-blue-500'}">
                    ${user.user_id.substring(0,1).toUpperCase()}
                </div>
                <span class="font-semibold text-gray-700">${user.user_id}</span>
            </div>
        </td>
        <td class="px-6 py-4 text-gray-600 font-medium">${user.user_name}</td>
        <td class="px-6 py-4 text-gray-500 text-sm">${user.user_email}</td>
        <td class="px-6 py-4 text-center">
            <span class="px-3 py-1 rounded-full text-[11px] font-bold
            	${user.user_role == 'admin' ? 'bg-purple-100 text-purple-600' : 'bg-gray-100 text-gray-600'}">
                ${user.user_role}
            </span>
        </td>
        <td class="px-6 py-4 text-gray-400 text-sm">
        	<fmt:parseDate value="${user.join_date}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedJoinDate" />
            <fmt:formatDate value="${parsedJoinDate}" pattern="yyyy-MM-dd"/>
        </td>
        <td class="px-6 py-4 text-right">
        	<div class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
	            <button class="p-2 hover:bg-blue-50 text-blue-600 rounded-md transition-colors" title="수정">
	                <i class="fas fa-edit"></i>
	            </button>
            </div>
        </td>
    </tr>
</c:forEach>