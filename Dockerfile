FROM ruby:2.5.1

# nodejsとmysql-client (default-mysql-client) のインストール
RUN apt-get update -qq && apt-get install -y curl apt-transport-https wget nodejs default-mysql-client

# Yarn のインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y yarn
  
# プロジェクトのディレクトリをコンテナに作成
RUN mkdir /muscle-app

# 作業ディレクトリに↑で作成したディレクトリを指定
WORKDIR /muscle-app

# Gemfileを作業ディレクトリにコピー
COPY Gemfile /muscle-app/Gemfile
COPY Gemfile.lock /muscle-app/Gemfile.lock

# gemのインストール
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler
RUN bundle install
COPY . /muscle-app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# コンテナ起動時にRailsサーバーが起動するようにする
CMD ["rails", "server", "-b", "0.0.0.0"]