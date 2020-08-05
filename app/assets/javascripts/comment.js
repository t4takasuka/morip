$(function(){
  function buildHTML(comment){
    var html =` <div class="card-text-comments">
                  <div class="row">
                    <div class="col-sm-2 col-md-2">
                      <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    </div>
                    <div class="col-sm-8 col-md-8">
                      ${comment.text}
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