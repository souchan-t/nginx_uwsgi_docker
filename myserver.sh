#!/bin/bash

# アプリケーションサーバのコンテナ名とイメージ名
APPSRVNAME1=appsrv1
APPSRVNAME2=appsrv2
APPSRVIMAGE=myappsrv_img

# プロキシサーバのコンテナ名とイメージ名
PROXYSRVNAME=proxysrv
PROXYSRVIMAEG=mywebsrv_img

# ポートフォワードするホストのポート番号
HOSTPORT=8080

# サーバー起動コマンド
if [ $1 = "run" ]; then

	echo "starting..."

	# アプリケーションサーバ1の起動
	docker run \
		-d\
		--rm\
		--name $APPSRVNAME1\
		-v $(pwd)/appserver/app:/var/www/app\
		$APPSRVIMAGE

	# アプリケーションサーバ2の起動
	docker run \
		-d\
		--rm\
		--name $APPSRVNAME2\
		-v $(pwd)/appserver/app:/var/www/app\
		$APPSRVIMAGE

	# プロキシサーバーの起動
	docker run \
		-d\
		--rm\
		--name $PROXYSRVNAME\
		-p $HOSTPORT:80\
		--link $APPSRVNAME1:$APPSRVNAME1\
		--link $APPSRVNAME2:$APPSRVNAME2\
		-v $(pwd)/proxyserver/www:/var/www\
		-v $(pwd)/proxyserver/conf.d:/etc/nginx/conf.d $PROXYSRVIMAEG
	
	echo "done"
	exit
fi

# サーバー停止
if [ $1 = "stop" ]; then
	echo "stopping..."
	docker stop $APPSRVNAME1
	docker stop $APPSRVNAME2
	docker stop $PROXYSRVNAME
	echo "done"
	exit
fi

# コンテナ削除
if [ $1 = "rm" ]; then
	echo "removing..."
	docker rm $APPSRVNAME1
	docker rm $APPSRVNAME2
	docker rm $PROXYSRVNAME
	echo "done"
	exit
fi

# イメージビルド
if [ $1 = "build" ]; then
	docker build -t $APPSRVIMAGE ./appserver/.
	docker build -t $PROXYSRVIMAEG ./proxyserver/.
	exit
fi

# イメージ削除
if [ $1 = "rmi" ]; then
	echo "removing images ..."
	docker rmi $APPSRVIMAGE
	docker rmi $PROXYSRVIMAEG
	echo "done"
	exit
fi

echo "Wrong Argument"
