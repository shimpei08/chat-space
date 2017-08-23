$(document).on('turbolinks:load', function() {

  function buildHTML(message) {
    var html =
      `<li class ="content__list">
        <h2 class="message__name">${message.name}</h2>
        <h4 class="message__created_at">${message.created_at}</h4>
        <p class="message__body">${message.body}</p>
      </li>`
    return html;
  }

  $('.comment').on('submit', function(e) {
// 次の動作をストップ
    e.preventDefault();
// 連続更新を可能に
    $('.comment__submit').removeAttr('data-disable-with');
//  formdataを一括で送る
    var message = new FormData($('.comment').get(0));
    var current_group_id = $('.main').data('group-id')
    $.ajax({
      type:        'POST',
      url:         '/groups/'+ current_group_id+ '/messages',
      data:        message,
      dataType:    'json',
// new Formdataを使うため
      processData: false,
      contentType: false
    })
    .done(function(data) {
      $('.content').prepend(buildHTML(data));
      $('.comment__message').val('');
    })
    .fail(function() {
      alert('error');
    });
  });

  // 自動更新のための関数
  var autoreload = function() {
    $.ajax({
      type:         'GET',
      url:          location.href,
      dataType:     'json'
    })
    .done(function(datas) {
      insertHTML = ''
      datas.forEach(function(data) {
        insertHTML += buildHTML(data);
      });
    })
    .fail(function(data) {
      alert('自動更新ができませんでした')
    });
  }
  var timer = setInterval(autoreload, 5000);
});
