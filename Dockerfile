# Pythonベースイメージを使用
FROM python:3.10
ENV PYTHONPATH=/project

# 作業ディレクトリを設定
WORKDIR /project
# アプリケーションのコードをコピー
COPY . /project
# 依存関係のリストをコピー
# 修正: ファイルのパスを正しく指定
COPY requirements.txt /project/

# 依存関係をインストール
RUN pip3 install --upgrade pip 
RUN pip3 install --no-cache-dir -r /project/requirements.txt