# docker cognito sample

# 前提
- aws cliのインストール

# cognito初期設定
```shell
# aws プロファイル設定（.aws.exampleに生成例をおいてある）
# profileはlocalで作成しているので、変更する場合は注意
$ aws configure --profile=local

# docker起動
$ docker-compose up -d

# 初期設定
$ chmod +x cognito.init.sh
$ ./cognito.init.sh
# この時点で表示されるuser_statusは無視出来る

# pool_idとclient_idはcognito_info.txtに出力される
# ユーザー確認(初期から変更がない場合)
# user_statusを確認して有効かどうか判断
aws cognito-idp list-users \
  --user-pool-id ${USER_POOL_ID} \
  --profile local \
  --endpoint-url http://localhost:2000
  
# ユーザー認証確認
aws cognito-idp admin-initiate-auth \
  --user-pool-id ${USER_POOL_ID} \
  --client-id ${CLIENT_ID} \
  --auth-flow ADMIN_NO_SRP_AUTH \
  --auth-parameters "USERNAME=hiyoko,PASSWORD=Hiyoko[13" \
  --profile local \
  --endpoint-url http://localhost:2000
```
