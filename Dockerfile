# Pythonのスリムなイメージを使用
FROM python:3.10-slim

# 作業ディレクトリの作成
WORKDIR /app

# 必要なパッケージをインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのソースコードをコピー
COPY . .

# ポート8000を開放
EXPOSE 8000

# 開発サーバーを起動するコマンド
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
