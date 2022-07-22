<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 수정</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">board modify</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-lg-6">
						<form role="form" action="/board/modify" method="post">
							<input type='hidden' name='pageNum'
								value='<c:out value="${cri.pageNum }"/>'> <input
								type='hidden' name='amount'
								value='<c:out value="${cri.amount }"/>'>

							<div class="form-group">
								<label>번호</label> <input class="form-control" name="bno"
									value='<c:out value="${board.bno}"/>' readonly="readonly">
							</div>

							<div class="form-group">
								<label>제목</label> <input class="form-control" name="title"
									value='<c:out value="${board.title}"/>'>
							</div>

							<div class="form-group">
								<label>내용</label>
								<textarea class="form-control" rows="3" name="content"><c:out
										value="${board.content}" /></textarea>
							</div>

							<div class="form-group">
								<label>작성자</label> <input class="form-control"
									placeholder="Enter text" name="writer"
									value='<c:out value="${board.writer}"/>' readonly>
							</div>

							<div class="form-group">
								<label>수정일자</label> <input class="form-control"
									name="updatedate"
									value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}"/>'
									readonly>
							</div>

							<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
							<button type="submit" data-oper='remove' class="btn btn-default">삭제</button>
							<button type="submit" data-oper='list' class="btn btn-info">목록</button>
						</form>
					</div>
					<!-- /.col-lg-6 (nested) -->

				</div>
				<!-- /.row (nested) -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript"> <!-- -->
	$(document).ready(function() {
		var formObj = $("form"); <!--$()는 el아니고 jquery다!!-->
	$('button').on("click", function(e) {
		e.preventDefault(); <!--태그가 갖는 기본기능을 일시 중지시키는 것이다.-->
		var operation = $(this).data("oper");
		console.log(operation);
		if(operation ==="remove"){
			formObj.attr("action","/board/remove");
			
		}else if(operation ==="list") {
			formObj.attr("action","/board/list").attr("method","get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		}
		formObj.submit();
	});
	});
</script>