<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="user" items="${userList}">
    <tr class="hover:bg-gray-50/50 transition-colors group border-b border-gray-50">
        <td class="px-6 py-4">
            <span class="font-bold text-gray-800">${user.user_id}</span>
        </td>

        <td class="px-6 py-4">
            <div class="text-gray-700 font-medium">
                <c:choose>
                    <c:when test="${user.user_type == 'business'}">
                        ${user.company_name} <span class="text-[11px] text-gray-400 font-normal">(담당: ${user.user_name})</span>
                    </c:when>
                    <c:otherwise>${user.user_name}</c:otherwise>
                </c:choose>
            </div>
        </td>

        <td class="px-6 py-4 text-gray-500 text-sm">
            ${user.user_email}
        </td>

        <td class="px-6 py-4 text-center">
            <div class="flex items-center justify-center gap-1.5">
                <i class="fas ${user.user_type == 'business' ? 'fa-building text-blue-400' : 'fa-user text-emerald-400'} text-[10px]"></i>
                <span class="text-xs font-semibold ${user.user_type == 'business' ? 'text-blue-600' : 'text-emerald-600'}">
                    ${user.user_type == 'business' ? '법인' : '개인'}
                </span>
            </div>
        </td>

        <td class="px-6 py-4 text-center">
            <span class="px-2.5 py-0.5 rounded text-[11px] font-bold shadow-sm
                ${user.user_role == 'admin' ? 'bg-purple-100 text-purple-600' : 
                  user.user_role == 'vip' ? 'bg-amber-100 text-amber-600' : 'bg-gray-100 text-gray-600'}">
                ${user.user_role.toUpperCase()}
            </span>
        </td>

        <td class="px-6 py-4 text-center text-gray-400 text-sm font-mono">
            <fmt:parseDate value="${user.join_date}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
        </td>

        <td class="px-6 py-4 text-right">
            <div class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                <button onclick="changeUserInfo('${user.user_id}')" class="p-2 hover:bg-blue-50 text-blue-600 rounded-md transition-all">
                    <i class="fas fa-edit"></i>
                </button>
                <button onclick="deleteUser('${user.user_id}')" class="p-2 hover:bg-red-50 text-red-600 rounded-md transition-all">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        </td>
    </tr>
</c:forEach>