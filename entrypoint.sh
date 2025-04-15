#!/bin/sh

# DBが応答するまで待機
echo "Waiting for postgres..."

# ncコマンドを使用して、DBのポートが開くまで待機
# -zオプションは、指定したホストとポートに接続できるかどうかを確認します
# -wオプションは、接続がタイムアウトするまでの時間を指定します
# ここでは、DBのホスト名をdb、ポート番号を5432に設定しています
# これにより、PostgreSQLが起動するまでスクリプトが待機します  
while ! nc -z db 5432; do
  sleep 0.5
done

echo "PostgreSQL started"

# Djangoを起動
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
