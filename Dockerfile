FROM ruby:2.5.1

# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs        

# rails c で日本語入力を可能にするために設定
ENV LANG C.UTF-8

RUN mkdir app

WORKDIR /app

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN bundle install -j8
