Rails.application.routes.draw do
  root 'users#index'      # ルートパスは「users」のindexに設定
  get 'contacts/index'    # 画面表示できるように設定
  get 'tweets/index'      # 画面表示できるように設定
end
