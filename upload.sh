#!/bin/bash

git remote set-url origin git@github.com:nomikazu-x/TIL.git
git pull
git add .
git commit -m "zennを保存"

# 1. .md形式の変更があったファイルのパスとファイル名を取得
CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD | grep '\.md$')

# 2. & 3. 変更があった.mdファイルごとに指定されたコマンドを実行
for FILE in $CHANGED_FILES; do
    # 変更があったファイルのパスを表示
    echo "Changed file path: $FILE"
    
    # ファイルのパスがarticles配下ではない場合、処理をスキップ
    if [[ ! $FILE =~ ^articles/ ]] || [[ ! -e $FILE ]]; then
        echo "Skip ztoq: $FILE"
        continue
    fi
    
    # .md拡張子を削除してファイル名を取得
    FILENAME=$(basename $FILE .md)
    
    # ファイル名と同じファイルがqiita/public配下に存在しない場合だけ、npx qiita newを実行
    if [ ! -e "qiita/public/$FILENAME.md" ]; then
        echo "Create qiita/public/$FILENAME.md"
        cd ./qiita
        npx qiita new "$FILENAME"
        cd ../
    fi

    # ./node_modules/.bin/ts-node scripts/ztoq.ts "取得したファイルパス" qiita/public/"取得したファイル名.md"を実行
    ./node_modules/.bin/ts-node scripts/ztoq.ts "$FILE" "qiita/public/$FILENAME.md"
    echo "Convert $FILE to qiita/public/$FILENAME.md"
done

# 最後にgit hubにあげる
git add .
git commit -m "zenn, qiitaを投稿"
git push