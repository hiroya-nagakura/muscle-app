FROM ruby:2.5.1

#The method driver /usr/lib/apt/methods/https could not be found.を回避
#RUN apt-get update && apt-get install apt-transport-https -y

# curl -sS でエラー以外の出力の抑制
#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# yarn node.js mysql-client (default-mysql-client)のインストール
#RUN apt-get update && \
#apt-get install -y yarn nodejs  default-mysql-client --no-install-recommends && \
#rm -rf /var/lib/apt/lists/*

# nodejsとmysql-client (default-mysql-client) のインストール
RUN apt-get update -qq && apt-get install -y curl apt-transport-https wget nodejs default-mysql-client

# Yarn のインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y yarn
  
# プロジェクトのディレクトリをコンテナに作成
RUN mkdir /muscle-app

# 作業ディレクトリに↑で作成したディレクトリを指定
WORKDIR /muscle-app

# Gemfileを作業ディレクトリにコピー
ADD Gemfile /muscle-app/Gemfile
ADD Gemfile.lock /muscle-app/Gemfile.lock

# gemのインストール
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler
RUN bundle install

# プロジェクト本体をコンテナにコピー
ADD . /muscle-app

# コンテナ起動時にRailsサーバーが起動するようにする
CMD ["rails", "server", "-b", "0.0.0.0"]