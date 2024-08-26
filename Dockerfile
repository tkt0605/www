# Pythonベースイメージを使用
FROM python:3.10

# 作業ディレクトリを設定
WORKDIR /project

# 依存関係のリストをコピー
# 修正: ファイルのパスを正しく指定
COPY requirements.txt /project/

# 依存関係をインストール
RUN pip3 install --upgrade pip 
RUN pip3 install --no-cache-dir -r /project/requirements.txt
    

# アプリケーションのコードをコピー
COPY . /project/

# WSGIサーバー（Gunicorn）を使用してDjangoアプリケーションを起動
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "project.wsgi:application"]
