# config valid for current version and patch releases of Capistrano
lock '~> 3.14.1'

set :application, 'muscle-app'
set :repo_url, 'git@github.com:hiroya-nagakura/muscle-app.git'
set :deploy_to, '/var/www/rails/muscle-app'

# Pumaに関する設定
# ソケットの場所、Nginxとのやり取りに必要
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
# サーバー状態を表すファイルの場所
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# プロセスを表すファイルの場所
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# ログの場所
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"

# タスクでsudoなどを行う際に必要
set :pty, true
# シンボリックリンクのファイルを指定、具体的にはsharedに入るファイル
set :linked_files, fetch(:linked_files, []).push('config/credentials/production.key')
# シンボリックリンクのディレクトリを生成
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads', 'public/storage'

# 環境変数の設定
set :default_env, { path: '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH' }
# 保存しておく過去分のアプリ数
set :keep_releases, 3

namespace :deploy do
  desc 'Create database'
  task :db_create do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, 'db:create'
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
end
