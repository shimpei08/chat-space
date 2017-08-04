$(document).on('turbolinks:load', function() {

  var search_result = $('#user_search-result');
// 削除ボタンの追加
  function buildRemoveButton(user) {
    var html =
      `
      <div class='chat-group-form__user__list'>
      <p class='chat-group-form__user__name'> ${user.name} </p>
      <a href='#' class='chat-group-form__user__btn--remove'>削除</a>
      <input type='hidden' name='group[user_ids][]' value='${user.id}'></input>
      </div>`;
      return html;
  }

// 削除ボタンを押したとき
  $(document).on('click', '.chat-group-form__user__btn--remove',
    function(e) {
      e.preventDefault();
       var user = { name: $(this).parent().find('p').html(), id: $(this).parent().find('input').attr('value') }
    buildAddButton(user);
    $(this).parent("div").remove();
    });
// インクリメンタルサーチで追加した時
  $(document).on('click', '.chat-group-form__user__btn--add', function(e) {
    e.preventDefault();
    var user = { name: $(this).parent().find('p').html(), id: $(this).parent().find('input').attr('value') }
    var delete_btn = buildRemoveButton(user);
    $('#registered_user').append(delete_btn);
    $(this).parent("div").remove();
  });

// 一致した場合
  function buildAddButton(user) {
    var html =
      `
      <div class='chat-group-form__user__list'>
      <p class='chat-group-form__user__name'> ${user.name} </p>
      <a href='#' class='chat-group-form__user__btn--add'>追加</a>
      <input type='hidden' name='add_user_ids' value='${user.id}'></input>
      </div>`;
    search_result.append(html);
  }
// 一致しない場合
  function buildNoData(input) {
    var html =
    `<p class='chat-group-form__user__name'> ${input} </p>`
    search_result.append(html);
  }

  $('#keyword').on('keyup', function(e) {
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
