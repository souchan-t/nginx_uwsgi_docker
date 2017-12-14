FROM alpine

RUN apk update

# Bashのインストール
RUN apk add --nocache nginx

# nginxのの設定
RUN mkdir /run/nginx

#ADD ./default.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
# Nginx起動コマンド
CMD ["nginx","-c","/etc/nginx/nginx.conf"]



