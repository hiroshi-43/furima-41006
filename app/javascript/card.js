//payという名前の関数を作っている。関数の宣言  const pay = () => { ... }
const pay = () => {
  // PAY.JP公開鍵を使ってPayjpオブジェクトを初期化.gon.public_key から公開鍵（publicKey）を取得しています。この鍵を使ってPayJPの設定を初期化します。
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) 
  //elements.create を使って、カード番号、期限、有効期限、CVCの各フィールドを作成します。
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');
  //mount メソッドで、これらのフィールドをHTMLの指定された場所（IDが #number-form, #expiry-form, #cvc-form 分）に配置します。
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  //フォームの送信イベントを設定
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // フォーム送信を一時的にキャンセル。まずクレジットカードのトークンを生成する処理を行うようにしています
    payjp.createToken(numberElement).then(function (response) {  //payjp.createToken(numberElement) を呼び出して、カード情報からトークンを生成します。
      if (response.error) {
      // エラーがあった場合の処理（何もしない、またはエラーメッセージを表示する）
      } else {
        // トークン生成が成功すれば、response.id にトークンが格納されます。これをフォームに隠し入力フィールドとして追加します。
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        //取得したトークンを隠しの入力フィールド（<input type="hidden">）としてフォームに追加します。
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      //その後、カード情報入力フィールドをクリアし、再度フォームの送信を行います
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
//この行は、ページが完全に読み込まれたタイミングで pay 関数を実行するようにしています。
//"turbo:load" イベントは、ページが完全に読み込まれたタイミングで発生します。

window.addEventListener("turbo:render", pay);
//ページの一部が再レンダリングされたときに pay 関数を再度実行するために使われています。