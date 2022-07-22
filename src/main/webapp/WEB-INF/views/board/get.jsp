<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시글 상세</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">기본양식</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-lg-6">
						<!-- 	<form role="form" action="/board/get" method="post"> -->
						<!-- get에서는 필요없어서 form 빼기 -->
						<div class="form-group">
							<label>번호</label> <input class="form-control" name="bno"
								value='<c:out value="${board.bno}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>제목</label> <input class="form-control" name="title"
								value='<c:out value="${board.title}"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea class="form-control" rows="3" name="content" readonly><c:out
									value="${board.content}" /></textarea>

						</div>

						<div class="form-group">
							<label>작성자</label> <input class="form-control" name="writer"
								value='<c:out value="${board.writer}"/>' readonly="readonly">
						</div>

						<button data-oper='modify' class="btn btn-default">수정</button>
						<button data-oper='list' class="btn btn-default">목록</button>

						<form id="operForm" action="/board/modify" method="get">
							<input type='hidden' id='bno' name='bno'
								value='<c:out value="${board.bno }"/>'> <input
								type='hidden' name='pageNum'
								value='<c:out value="${cri.pageNum }"/>'> <input
								type='hidden' name='amount'
								value='<c:out value="${cri.amount }"/>'> <input
								type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
							<input type='hidden' name='keyword'
								value='<c:out value="${cri.keyword }"/>'>
						</form>
						<!-- </form>  -->
						<!-- get에서는 필요없어서 form 빼기 -->

					</div>
					<!-- /.col-lg-6 (nested) -->

				</div>
				<!-- /.row (nested) -->

				<!-- 새로운 댓글을 추가할 수 있도록 해준다. -->
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> Reply
					<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New
						Reply</button>
				</div>

			</div>
			<!-- /.panel-body -->

		</div>
		<!-- /.panel -->

	</div>
	<!-- /.col-lg-12 -->

</div>
<!-- /.row -->


<!-- 댓글 -->
<div class="row">
	<div class="col-lg-12">
		<!--  /.pannel  -->
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">

				<ul class="chat">
					<!--  start reply -->
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong> <small
									class="pull-right text-muted">2022-07-15 15:18</small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
					<!--  end reply -->
				</ul>
				<!--  ./ end ul -->
			</div>
			<!-- /.panel .chat-panel -->

			<div class="panel-footer"></div>

		</div>
	</div>
	<!-- ./ end row -->
</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">댓글 등록</h4>
			</div>
			<div class="modal-body">
				<div class="modal-group">
					<label>댓글</label> <input class="form-control" name="reply"
						value="new reply!!">
				</div>
				<div class="modal-group">
					<label>작성자</label> <input class="form-control" name="replyer"
						value="replyer">
				</div>
				<div class="modal-group">
					<label>작성일</label> <input class="form-control" name="replydate"
						value="replydate">
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" id="modalModBtn" class="btn btn-warning"
					data-dismiss="modal">Modify</button>
				<button type="button" id="modalRemoveBtn" class="btn btn-danger"
					data-dismiss="modal">Remove</button>
				<button type="button" id="modalRegisterBtn" class="btn btn-primary"
					data-dismiss="modal">Register</button>
				<button type="button" id="modalCloseBtn" class="btn btn-default"
					data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->



<%@include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		console.log("==================")
		console.log("JS TEST")

		var bnoValue = '<c:out value = "${board.bno}"/>';
		
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			replyService.getList({bno : bnoValue, page : page || 1}, 
					function(replyCnt, list) {
				
				console.log("replyCnt: " +replyCnt);
				console.log("list: " +list);
				console.log(list);
				
				if(page==-1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str ="";
				if(list==null || list.length==0) { <!--댓글이 없으면, 이라는 말-->
					replyUL.html(""); <!--아무것도 넣어주지말고 리턴하면돼 -->
					return;
				}
				for (var i = 0, len = list.length || 0; i<len; i++) {
					str+= "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str+="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str+= "<small class='pull-right text-muted'>"
					+replyService.displayTime(list[i].replydate)+"</small></div>"
					
					str += "<p>"+list[i].reply+"</p>"
					str+="</div></li>"					
				}
				replyUL.html(str);
				
				showReplyPage(replyCnt);
	}); //end function
	}//end showList	
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplydate = modal.find("input[name='replydate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalCloseBtn = $("#modalCloseBtn");
	
	/*Reply버튼에 대한 이벤트 생성하기!!*/
	$('#addReplyBtn').on("click",function(e){
		modal.find("input").val("");
		modalInputReplydate.closest("div").hide(); /*가장 가까운 조상을 찾아서 hide로 바꿔. 따라서, 작성일자를 안보이게 해줄거야*/
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
	});
	
	/*register 버튼을 클릭하면, */
	modalRegisterBtn.on("click",function(e){
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			};
			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				showList(-1); /*새 댓글 추가 시 마지막 페이지로 호출. 댓글이 새롭게 등록되고 알림창을 hide하게 되면, 하단 댓글목록에도 새로고침이 바로 반영될수 있도록 showlist불러주기*/
			});
	});
	
	/*댓글이 클릭되게 하고 클릭되면 댓글 상세보기하고, 상세조회에서 수정이나 삭제할 수 있도록 만들어주는 작업*/
	$(".chat").on("click", "li", function(e){
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply); /*댓글의 내용을 가져가는거*/
			modalInputReplyer.val(reply.replyer); /*댓글의 작성자를 가져가는거*/
			modalInputReplydate.val(replyService.displayTime(reply.replydate)).attr("readonly","readonly"); /*readonly타입의 readonly,, 사실 하나만써도 됌. 댓글의 작성날짜를 가져가는거*/
			modal.data("rno", reply.rno);
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalInputReplydate.closest("div").show();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	});
	
	modalModBtn.on("click",function(e){
		var reply = {
				rno : modal.data("rno"), reply:modalInputReply.val() /*jquery문*/
		};
		replyService.update(reply, function(result) {
			alert(result);
			modal.modal("hide");
			showList(pageNum); /*괄호안에 1이 아닌 pageNum을 줌으로써 현재 보고 있는 댓글 페이지의 번호를 호출한다.*/
		});
	});
	
	modalRemoveBtn.on("click",function(e){
		var rno = modal.data("rno");
				replyService.remove(rno, function(result) {
					alert(result);
					modal.modal("hide");
					showList(pageNum); /*괄호안에 1이 아닌 pageNum을 줌으로써 현재 보고 있는 댓글 페이지의 번호를 호출한다.*/
				});		
	});
	
	var pageNum =1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1; /*prev 버튼은 해당 페이지가 1이면 필요없음 따라서 1페이지일때 false*/
		var next = false;
		
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt / 10.0)
		}
		
		if (endNum * 10 < replyCnt ) {
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		if(prev){
			str += "<li class='page-item'><a class='page-link' href='"+(startNum - 1)+"'>Previous</a></li>";
		}
		
		for(var i=startNum; i<=endNum; i++) {
			var active = pageNum ==1?"active":"";
			str += "<li class='page-item'" + active + "'><a class='page-link' href='"+i +"'>" + i +"</a></li>"
		}
		
	str += "</ul></div>";
	console.log(str);
	replyPageFooter.html(str);
	}
	
	/*페이지의 번호를 클릭했을 때 새로운 댓글을 가져오도록 하는 부분. - 내가 책보고 넣은 부분 p.441*/
	replyPageFooter.on("click", "li a", function(e) {
		e.preventDefault();
		console.log("page click");
		var targetPageNum = $(this).attr("href");
		console.log("targetPageNum: "+targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
	});
	
		//for replyService add Test
		/*replyService.add({
			reply : "JS TEST",
			replyer : "tester",
			bno : bnoValue
		}, function(result) {
			alert("RESULT : " + result);
		});*/

		//for replyService getList Test
		/*replyService.getList({
			bno : bnoValue,
			page : 1
		}, function(list) {
			for (var i = 0, len = list.length || 0; i < len; i++) {
				console.log(list[i]);
			}
		});*/

		//for replyService delete Test
		/*	replyService.remove(61, function(count) {
				console.log(count);
				if (count === "success") {
					alert("REMOVE 성공했음.");
				}
			}, function(err) {
				alert("REMOVE ERROR...");
			});*/

		//2번 댓글 수정
		/*replyService.update({
			rno : 6,
			bno : bnoValue,
			reply : "Modified Reply....."
		}, function(result) {
			alert("수정 완료...");
		});*/

		/* replyService.get(7, function(data) {
			console.log("댓글 한건 읽기 테스트 잘됨." + data);
		});

		console.log(replyService)*/
	});
</script>

<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on('click', function(e) {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		})
	})
</script>