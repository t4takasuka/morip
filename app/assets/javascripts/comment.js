$(document).on('turbolinks:load', function(){
  function buildHTML(comment){
    var html =` <div class="card-text-comments">
                  <div class="row">
                    <div class="col-sm-2 col-md-2">
                      <a class ="name" href="/users/${comment.user_id}">${comment.user_name}</a>
                    </div>
                    <div class="col-sm-8 col-md-8 card-text">
                      <%= simple_format${comment.text} %>
                    </div>
                    <div class="col-sm-2 col-md-2">
                      <a rel="nofollow" data-method="delete" href="/posts/${comment.post_id}/comments/${comment.id}">削除</a>
                    </div>
                  </div>
                </div>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false,
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.card.comments').append(html);
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  });
});