<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="/WEB-INF/view/include/top.jsp" />

<section id="sign_form">
    <div align="center">
        <br>
        <a href="${path}/index.do?page=1">
            <img id="login_box_logo" src="https://raw.githubusercontent.com/DaegeunYu/Spring80ShopImg/refs/heads/main/logo.jpg">
        </a>
        
        <div class="join-card"> <h2 class="join-title">80's BUSINESS JOIN</h2>
            <form action="${path}/users/businessJoin.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                <table id="join_table">
                    <tr>
                        <td><input type="text" id="user_id" name="user_id" placeholder="아이디" required></td>
                    </tr>
                    <tr>
                        <td><button type="button" class="btn-full gray-btn" onclick="checkId()">아이디 중복 확인</button></td>
                    </tr>
                    <tr>
                        <td><input type="password" id="user_pw" name="user_pw" placeholder="비밀번호" required></td>
                    </tr>
                    <tr>
                        <td><input type="password" id="user_pw2" placeholder="비밀번호 확인" required></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="companyName" placeholder="상호명" required></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="ceoName" placeholder="대표자명" required></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="bizRegNo" placeholder="사업자 번호 (000-00-00000)" required></td>
                    </tr>
                    <tr>
                        <td>
						    <select name="bizType" class="biz-select">
						        <option value="" disabled selected>사업자 유형 선택</option>
						        <option value="간이사업자">간이사업자</option>
						        <option value="일반사업자">일반사업자</option>
						        <option value="법인사업자">법인사업자</option>
						        <option value="면세사업자">면세사업자</option>
						    </select>
						</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="user_tel" placeholder="전화번호" required></td>
                    </tr>
                    <tr>
                        <td><input type="email" name="user_email" placeholder="이메일"></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="user_add" placeholder="사업장 주소"></td>
                    </tr>
                    <tr>
                        <td class="file-label">사업자등록증 첨부</td>
                    </tr>
                    <tr>
                        <td><input type="file" name="file" accept="image/*" required></td>
                    </tr>
                    <tr>
                        <td>
                            <br>
                            <input type="submit" value="법인 회원가입" class="btn-full dark-btn">
                            <input type="button" value="취소" class="btn-full cancel-btn" onclick="history.back()">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var idCheckDone = false; // 중복체크 여부

function checkId() {
    var userId = document.getElementById("user_id").value;
    if(userId == "") {
        alert("아이디를 입력해주세요.");
        return;
    }
    
    $.ajax({
        url: "${path}/users/idCheck.do",
        data: { user_id: userId },
        success: function(res) {
            if(res.trim() === "T") {
                alert("이미 사용 중인 아이디입니다.");
                idCheckDone = false;
            } else {
                alert("사용 가능한 아이디입니다.");
                idCheckDone = true;
            }
        }
    });
}

function validateForm() {
    if(!idCheckDone) {
        alert("아이디 중복 체크를 완료해주세요.");
        return false;
    }
    var pw1 = document.getElementById("user_pw").value;
    var pw2 = document.getElementById("user_pw2").value;
    if(pw1 !== pw2) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
    }
    return true;
}
</script>
<c:import url="/WEB-INF/view/include/bottom.jsp" />