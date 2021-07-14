FROM ruby:2.7.3

ENV RAILS_ENV=production

# 必要なライブラリのインストール
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#   && apt-get update -qq \
#   && apt-get install -y nodejs yarn

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn

# /app を作業ディレクトリに指定
WORKDIR /app

# ローカルのソースコードの場所を /app 以下に固定
COPY ./src /app

# Ruby関連のライブラリのインストール
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

COPY start.sh /start.sh
# 実行権限を追加
RUN chmod 744 /start.sh
# start.sh ファイルをDocker側に追加して実行権限を付与
CMD ["sh", "/start.sh"]