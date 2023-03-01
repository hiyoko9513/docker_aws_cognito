#bin/zsh

COGNITO_POOL_NAME="HiyokoPool"
COGNITO_CLIENT_NAME="HiyokoClient"
COGNITO_HOST="http://localhost:2000"
COGNITO_ADMIN_USER_NAME="hiyoko"
COGNITO_ADMIN_USER_EMAIL="hiyoko_user@example.com"
COGNITO_ADMIN_USER_PASSWORD="Hiyoko[13"

# ユーザープールの作成
USER_POOL_ID=$(
  aws cognito-idp create-user-pool \
    --pool-name ${COGNITO_POOL_NAME} \
    --query UserPool.Id \
    --output text \
    --profile local \
    --endpoint-url ${COGNITO_HOST} \
)
echo "USER_POOL_ID=${USER_POOL_ID} \\" >> ./cognito_info.txt

# クライアントの作成
CLIENT_ID=$(
  aws cognito-idp create-user-pool-client \
    --client-name ${COGNITO_CLIENT_NAME} \
    --user-pool-id ${USER_POOL_ID} \
    --query UserPoolClient.ClientId \
    --output text \
    --profile local \
    --endpoint-url ${COGNITO_HOST} \
)
echo "CLIENT_ID=${CLIENT_ID} \\" >> ./cognito_info.txt

# ユーザー
# 作成
aws cognito-idp admin-create-user \
  --user-pool-id ${USER_POOL_ID} \
  --username ${COGNITO_ADMIN_USER_NAME} \
  --user-attributes Name=email,Value=${COGNITO_ADMIN_USER_EMAIL} Name=email_verified,Value=true \
  --message-action SUPPRESS \
  --profile local \
  --endpoint-url ${COGNITO_HOST}
# パスワード設定
aws cognito-idp admin-set-user-password \
  --user-pool-id ${USER_POOL_ID} \
  --username ${COGNITO_ADMIN_USER_NAME} \
  --password ${COGNITO_ADMIN_USER_PASSWORD} \
  --permanent \
  --profile local \
  --endpoint-url ${COGNITO_HOST}
