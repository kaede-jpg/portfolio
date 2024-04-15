**■サービス概要**
「ぷに活監視システム（仮）」は、家族・友人にダイエット（食事管理）を監視してもらうことができるサービスです。

**■ このサービスへの思い・作りたい理由**
夫がダイエットしているにも関わらず、食事制限を継続できない様子にもどかしさを感じていたことから着想を得ました。
ダイエットは自分との闘いというイメージを覆し、誰かに自分を見張ってもらいたい！というニーズを形にしました。
監視する側のカロリー感覚がなくても、たくさん反応ができるよう補助する仕組みを工夫したいです。

**■ ユーザー層について**
意志が弱くダイエットが継続できず、周りの人と楽しみながらゆるいダイエットがしたい人。
また、家族や友人にダイエットしてほしいと考えている人。
これらを満たす、家族・恋人・友人などの親しい関係にある1対3人以下のグループ。

**■サービスの利用イメージ**
ダイエットを行う側は、食事を画像で記録することができ、もらったスタンプの意味ごと（怒り・賞賛・応援など）の集計と、それによる点数付け（マイナスも存在する）やコメントを閲覧できる。
監視する側は、以下の機能を通してダイエットを監視し介入することができる。
・食事の記録を閲覧
・励ましや怒り、アドバイスのスタンプやコメントを送る
  監視者のスタンプを表示するのは画面の周り部分で、たくさんのスタンプを送ると画面が埋まってしまう。
  スタンプやコメントを送る際、画像認識で記録された画像が何の食品かを判定し、そのカロリーに応じてキャラクターから出されたコメントを閲覧できる。
    例）「こいつ、○○を食ってるよ！！○○kcalもあるのに…許せない。スタンプをたくさん送って自分のやったことを理解させてやる！！！」
    「今日のごはんは○○みたいだね。○○kcalくらいだし、まぁ許してやるか…」
    「今日のごはんは○○みたいだね。○○kcalくらいだよ！がんばってるじゃん！応援のスタンプを送ろうよ！」
    認識失敗（適当な自炊など？）した場合→「これは…なんだろう？犬のエサみたいだね。僕にはちょっとわからないけど、頑張ってるみたい…？」
・食事や運動の記録更新または記録漏れについての通知を受け取る

**■ ユーザーの獲得について**
RUNTEQコミュニティ内やinstagram・Xで、知人に使ってもらい口コミで広げてもらうことを目指します。

**■ サービスの差別化ポイント・推しポイント**
ダイエットにおいてよくある「誰かに自分を監視してほしい」という声を形にしました。どさくさに紛れて飯テロをすることも可能です。
キャラクターの辛辣な言葉が会話のタネになる点、他者からの反応をオーバーに表現するなどの点において、XなどのSNSでハッシュタグをつけて発信するなどの行為と差別化していきたいと考えています。

**■ 機能候補**
・MVPリリース時に作っていたいもの
  トップページ
  会員登録・ログイン
  アカウント同士の連携・ロールの設定機能
  食事画像の記録機能
  コメント・スタンプ機能（スタンプはいくつか自作したい）
  過去の記録、もらったスタンプの集計が閲覧できる機能

・本リリースまでに作っていたいもの
  スタンプで画面が埋まるUI
  投稿ごとに、スタンプの集計による点数が閲覧できる機能
  画像解析を用いた画像判定機能
  監視する側へキャラクターのコメントを提示する機能
  LINE・メール等での招待URL（連携・ロールの設定が可能）送信機能
  Google・LINEでのソーシャルログイン機能
  LINE通知（更新/未更新リマインド）機能
  定期的な未更新通知機能
  フロントエンドのReactへの置き換え

**■ 使用予定の技術スタック**
開発環境: Docker
サーバサイド: Ruby on Rails 7系
  Ruby 3.2.3 Rails 7.1.4.3
フロントエンド: JavaScript
CSSフレームワーク:　Tailwind
WebAPI: Google Cloud Vision API、Google API、LINE API
インフラ:
  Webアプリケーションサーバ: Heroku
  ファイルサーバ: AWS S3
その他：
  VCS: GitHub
  CI/CD: GitHubActions

**■ 機能の実装方針予定**
・アカウントの連携機能
  片方が発行したコードをもう片方が入力することで、アカウント同士の連携ができるようにする。
  本リリースでは上記に加えて、片方が発行したURLから会員登録をすることでアカウント同士の連携ができるようにする。
・招待URL、LINE通知（更新/未更新リマインド）機能
  whenever、LINE APIを使用する。
  バックグラウンド処理を行う。
・画像解析
  Google Cloud Vision APIを使用する。
・カロリー計算
  文部科学省のデータを整理しデータベースを作成する。
・監視する側へのキャラクターによるコメント
  画像解析結果の食品名とデータベースから出されたカロリーから、条件分岐で表示を変化させる。
・スタンプで画面を埋もれさせる機能
  何個目のスタンプをどこに配置するのか設定しておく。（一定以上送ると画面の状況は変わらなくなる）

  **■ 画面遷移図**
https://www.figma.com/file/tRysgu7gEyZI32HNSIl9FB/portfolio?type=design&node-id=0%3A1&mode=design&t=C2Aj8zitTiE7NrDC-1

  **■ ER図**
https://drive.google.com/file/d/1OVnCNF-uCuxaKUU1m1V6TYiBOCORV3af/view?usp=sharing
