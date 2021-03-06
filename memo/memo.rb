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


パンくずの設定を行う
パンくずの親子関係を設定するファイルを作成
下記コマンドを実行

ターミナル
% rails g gretel:install

以下のファイルが生成されれば成功です。
config/breadcrumbs.rb

crumb :xx do ... endの「do」と「end」の間に、
アクセスしたいビューのパスや親要素を指定する。

記述方法は以下になる。
【例】confing/breadcrumbs.rb
crumb "現在のページ名（表示させるビューにもページ名記述）" do
  link "パンくずリストでの表示名", "アクセスしたいページのパス"
  parent :親要素のページ名（前のページ）
end

作成したファイルを、下記のように編集
config/breadcrumbs.rb
crumb :root do
  link "Home", root_path
end

crumb :tweets do
  link "ツイート一覧", tweets_index_path
  parent :root
end

crumb :contacts do
  link "コンタクト", contacts_index_path
  parent :tweets
end



ビューを編集
application.html.erbを下記のように編集
views/layouts/application.html.erb
<!DOCTYPE html>
<html>
<head>
  <title>Breadcrumb</title>
  <%= csrf_meta_tags %>
  <%= csp_meta_tag %>
  <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
  <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
</head>
<body>
  <%= breadcrumbs separator: " &rsaquo; " %>  ###追加###
  <%= yield %>
</body>
</html>

今回の記述により、breadcrumbs.rbファイルで、
実装したパンくずが画面に表示される。
# separator: " &rsaquo;”は、パンくず間の区切りである「>」を示します。

各indexファイルの編集を行う。
# app/views/users/index.html.erb
# <h1>Users#index</h1>
# <p><%= link_to "ツイートへ", tweets_index_path %></p>
# <% breadcrumb :root %>

app/views/tweets/index.html.erb
# <h1>Tweets#index</h1>
# <p><%= link_to "コンタクトへ", contacts_index_path %></p>
# <% breadcrumb :tweets %>

app/views/contacts/index.html.erb
# <h1>Contacts#index</h1>
# <p>Find me in app/views/contacts/index.html.erb</p>
# <% breadcrumb :contacts %>

3行目にbreadcrumbs.rbで設定した、ページ名を記述している。


ブラウザで確認
ここまで実装できたらサーバーを再起動させ、
localhost:3000に接続して確かめる。

要点チェック
パンくずとは、ユーザーの位置をわかりやすく示すためにWebページを階層順にして、
リンクを設置したリストを画面に表示させる機能のこと

パンくずは、親子関係を設定することで、リンクを残すことができること