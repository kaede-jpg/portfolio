![logo_title_row](https://github.com/user-attachments/assets/97371bf0-b5e9-4beb-908d-af11ca61f57a)

**「ぷに活監視システム」は、家族・友人にダイエット（食事管理）を監視してもらうことができるサービスです。**  
ゲストログイン機能を実装しましたので、登録せずに機能の一部をお試しいただけます。
[https://www.punikatsu-monitor.com/](https://www.punikatsu-monitor.com/)

**■ このサービスへの想い**  
　夫がダイエットしているにも関わらず、食事制限を継続できない様子にもどかしさを感じていたことから着想を得ました。ダイエットは自分との闘いというイメージを覆し、「誰かに自分を見張ってもらいたい」というニーズを形にすることを目指しました。  
　このサービスは、他人にダイエットをさせたい人や「ダイエットしたい」と口にしつつ始められない人をターゲットにし、親しい人とのコミュニケーションを基盤とすることで、「食事写真の画像認識でPFCバランスまで管理」「ウェアラブルデバイスのデータで運動量を管理」などの自己管理型ダイエットと差別化を試みています。そのために、監視する・監視されるという片方が優位に立っている歪な関係を作り、監視できる人数を1人対1~3人に制限し1人当たりの責任を重くしています。また、他人に監視されているプレッシャーを重視しているので、記録忘れのリマインド等はあえて監視する側に通知し、リアルなどで指摘させる形にしています。  
　さらに、使用感を向上させるため、以下のような仕組みを工夫しています。  
* 監視される側が記録するものは食事の写真だけ  
* 監視する側がつけるスタンプを食事画像の上に大量に載せ、連打したくなるようにする  
* 監視する側のカロリー感覚がなくても、たくさんリアクションができるよう、画像認識によって食事名とカロリーを表示  

**■サービスの利用イメージ**  
ダイエットを行う側は、食事を画像で記録することができ、もらったスタンプのの集計と、それによる点数付けやコメントを閲覧できる。  
監視する側は、以下の機能を通してダイエットを監視し介入することができる。  
* 食事の記録を閲覧
* 励ましや怒り、アドバイスのスタンプやコメントを送る  
  監視者のスタンプを表示するのは画面の周り部分で、たくさんのスタンプを送ると画面が埋まってしまう。  
  スタンプやコメントを送る際、画像認識で記録された画像が何の食品かを判定し、その食事名とカロリーを閲覧できる。
* 食事や運動の記録更新または記録漏れについてのLINE通知を受け取る   

**■ 機能一覧**   
| トップページ | 会員登録 | ゲストログイン | パスワードリセット |
| - | - | - | - |
| <img src="https://github.com/user-attachments/assets/1b2a3700-3168-48e6-a21a-ced17b5dd695"> | <img src="https://github.com/user-attachments/assets/d107452e-34b2-4e8e-a023-37258b32af23"> | <img src="https://github.com/user-attachments/assets/f8a16852-c569-4361-b311-5593582706b1"> | <img src="https://github.com/user-attachments/assets/4b818608-5f11-48b4-92a3-c749d8513178" width="200"><img src="https://github.com/user-attachments/assets/06b94c6c-3ddc-437f-97d2-715f75e2b27b" width="200"> |
| あ | LINEログインが可能、ユーザーアクティベーションが必要 | あ | あ |  

| アカウント同士の連携 | ユーザー情報の確認・編集 |
| - | - |
| <img src="https://github.com/user-attachments/assets/e54d8178-e871-45ab-9739-4a4cbc09aa93" width="200"><br><img src="https://github.com/user-attachments/assets/d6968fd1-1e42-4c38-88f8-25b788485d94" width="200"><img src="https://github.com/user-attachments/assets/e2c9afb8-5b59-4cdc-9e9e-057b5ebf18c1" width="200"> | <img src="https://github.com/user-attachments/assets/1b2a3700-3168-48e6-a21a-ced17b5dd695" width="200"> |
| あ | あ |  

| <監視される側><br>食事画像の記録 | <監視する側><br>画像認識による食事名とカロリーの表示 | <監視する側><br>スタンプ | <監視される側><br>スタンプによるスコア |
| - | - | - | - |
| <img src="https://github.com/user-attachments/assets/0bd2d7e9-01a1-4803-b6e4-235b13e7fe84"> | <img src="#"> | <img src="https://github.com/user-attachments/assets/f36af3ee-37e7-444b-8c65-8f0725364c02"> | <img src="https://github.com/user-attachments/assets/22395a11-47be-4973-a318-5be6fee10f92"> |
| あ | あ | あ | あ |  

| コメント | <監視する側><br>LINE通知（更新/未更新リマインド） |
| - | - |
| <img src="https://github.com/user-attachments/assets/44cb2f7e-63d7-4f60-a87f-34a67ce80b12" width="200"> | <img src="#" width="200"> |
| あ | あ |  

**■ 使用技術**  
| カテゴリー | 技術スタック |
| - | - |
| フロントエンド | JavaScript, TailwindCSS, DaisyUI |
| バックエンド | Ruby 3.2.3 Rails 7.1.4.3 |
| インフラ | Heroku, AWS S3 |
| データベース | PostgreSQL |
| 開発環境 | Docker |
| CI/CD | GitHub Actions |
| WebAPI | LINE Messaging API、OpenAI API（GPT-4o mini） |
| VCS | GitHub |
| その他ツール | Figma, Canva, draw.io |

  **■ 画面遷移図**  
https://www.figma.com/file/tRysgu7gEyZI32HNSIl9FB/portfolio?type=design&node-id=0%3A1&mode=design&t=C2Aj8zitTiE7NrDC-1  

  **■ ER図**  
https://drive.google.com/file/d/1OVnCNF-uCuxaKUU1m1V6TYiBOCORV3af/view?usp=sharing  

  **■ インフラ構成図**  

  **■ 今後の展望**  
  記録状態をデータ化して簡単に振り返ることができる機能や、招待URLをLINEで送信できる機能を実装予定です。   