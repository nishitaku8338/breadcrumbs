目的
Webページを階層順にして、
リンクを設置したリストを画面に表示させる機能を実装


リンクを設置したリストを画面に表示させる機能
パンくず機能を把握
パンくずを実装する利点は、
Webサイトを利用しているユーザーが、
どのページにアクセスしているのか一目でわかること。
アクセス場所がわかることによって、サイトの巡回が行いやすくなる。

例として、旅行会社のホームページで、旅行先を調べている場面を考える。
トップページに最初の選択肢で、「国内」と「海外」があり、
「国内」を選択したとする。
次に「国内」の中には、北海道などの観光地が選択肢として表示される。

「トップページ」の中に「国内」があり、
「国内」の中に「北海道」があるように、
要素同士が紐付いており、親要素・子要素の関係であることを指す。


パンくず機能の実装
Gemをインストール
パンくずの実装には、gretelというGemを使用する。
gretelを用いることで、
リンクを設置したリストを画面に表示する機能を実装できる。

Gemfile
# 中略
gem "gretel"

記述したら、bundle installを実行しましょう。


ターミナル
% bundle install


今回は、「users」「tweets」「contacts」の3つのコントローラーを作成し、
各indexファイルを「users」「tweets」「contacts」の順で階層を分けて、
パンくずを実装する。



ルーティングを設定
ルートパスは「users」のindexに設定して、
「tweets」と「contacts」は、
画面表示できるように設定する。

config/routes.rb
Rails.application.routes.draw do
  root 'users#index'
  get 'contacts/index'
  get 'tweets/index'
end


コントローラーを作成
コントローラーを3つ作成

ターミナル
% rails g controller users
% rails g controller tweets
% rails g controller contacts


パンくずのリストを表示する、ビューを作成する
app/views/users/index.html.erb
<h1>Users#index</h1>
<p><%= link_to "ツイートへ", tweets_index_path %></p>

app/views/tweets/index.html.erb
<h1>Tweets#index</h1>
<p><%= link_to "コンタクトへ", contacts_index_path %></p>

app/views/contacts/index.html.erb
<h1>Contacts#index</h1>
<p>Find me in app/views/contacts/index.html.erb</p>


ここまで実装できたら、
サーバーを立ち上げlocalhost:3000に接続して確かめる。

以下のような表示がされていれば成功。
gazou2.png

上記図の「ツイートへ」をクリックすると、
下記図の「Tweets#index」へ遷移する。
gazou3.png

上記図の「コンタクトへ」をクリックすると、
下記図の「Contacts#index」へ遷移します。
gazou4.png


