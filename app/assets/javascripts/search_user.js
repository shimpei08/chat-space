$(document).on('turbolinks:load', function() {

  var search_result = $('#user_search-result');

// 一致した場合
  function buildAddButton(user) {
    var html =
      `<p class='chat-group-form__member__name'> ${user.name} </p>
      <a href='#' class='chat-group-form__member__btn--add'>追加</a>
      <input type='hidden' name='add_user_ids' value='${user.id}'></input>`;
    search_result.append(html);
  }
// 一致しない場合
  function buildNoData(input) {
    var html = `<p class='chat-group-form__member__name'> ${input} </p>`
    search_result.append(html);
  }
  $(".chat-group-form__input").on('keyup', function(e) {
    $('#user_search_result').empty();
    var input = $("#keyword").val();
  // インクリメンタルサーチをする
    $.ajax({
      type: 'GET',
      url: '/users/search',
      data: {keyword: input},
      datatype: 'json'
      })

    .done(function(datas) {
      $('#user_search-result').empty();
      if (datas.length !== 0) {
        datas.forEach(function(data){
          buildAddButton(data);
        });
      }

      else {
        buildNoData("一致する人物はいません。");
      }
    })

    .fail(function() {
      console.log('error');
    });
  });
});
