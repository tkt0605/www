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
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./project/templates/ /usr/share/nginx/html

# エントリーポイントスクリプトをコピーし、実行権限を付与
COPY ./docker-entrypoint.sh ./project/docker-entrypoint.sh
# COPY ./project/docker-entrypoint.sh ./docker-entrypoint.sh 
RUN chmod +x /project/docker-entrypoint.sh
# エントリーポイントとコマンドを設定
ENTRYPOINT ["/project/docker-entrypoint.sh"]

CMD ["gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000"]