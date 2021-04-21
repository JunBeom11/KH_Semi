<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="modal fade" id="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="modal-title">Modal title</h4>
			</div>
			<div class="modal-body" id="modal-body">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" id="modal-close-btn" data-dismiss="modal">닫기</button>
				<!-- <button type="button" class="btn btn-primary" id="modal-save-btn" >저장</button> -->
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
	$('#modal').on('hide',function(){
		$('#modal-close-btn').show();
		//$('#modal-save-btn').show();		 
	});
</script>