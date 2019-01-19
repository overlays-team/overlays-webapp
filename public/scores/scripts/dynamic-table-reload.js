$(function() {
  //検索ボタンがクリックされたら処理が走ります。
  $('#search_button').click(function() {
                //HTMLから受け取るデータです。
                var data = {request : $('#request').val()};
                //ここからajaxの処理です。
                $.ajax({
                        //POST通信
                        type: "GET",
                        //ここでデータの送信先URLを指定します。
                        url: "scores_updated_at_desc_with_ranking",
                        data: data,
                        //処理が成功したら
                        success : function(data, dataType) {
                            //HTMLファイル内の該当箇所にレスポンスデータを追加します。
                            $('#res').html(data);
                        },
                        //処理がエラーであれば
                        error : function() {
                            alert('通信エラー');
                        }
                 });
                 //submitによる画面リロードを防いでいます。
                 return false;
    });
  });
