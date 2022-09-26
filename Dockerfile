FROM ruby

RUN apt-get update && apt-get install -y nodejs npm
RUN npm install -g yarn

RUN mkdir /chat_ruby_app

WORKDIR /chat_ruby_app