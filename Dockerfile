# Pythonのスリムなイメージを使用
FROM python:3.10-slim

# 作業ディレクトリの作成
WORKDIR /app

# システムパッケージのインストール（curl, netcat, pip関連アップグレード）
RUN apt-get update && apt-get install -y \
    curl \
    netcat-openbsd \
    && pip install --upgrade pip setuptools wheel \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 必要なパッケージをインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのソースコードをコピー
COPY . .

# エントリーポイントスクリプトをコピーして実行権限を付与
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# ポート8000を開放
EXPOSE 8000

# エントリーポイントの設定
ENTRYPOINT ["/entrypoint.sh"]




# 開発サーバーを起動するコマンド⇒entrypoint.shで実行するためコメントアウト
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]