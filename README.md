# CSV Translator

GithubActionsのワークフロー内でAWS SDKを利用するRubyのコードを実行するサンプル。

GithubActionsを実行する前に以下のAWSリソースを作成する必要がある。

- OidcProvider
- IAM Role
- IAM Policy

CloudFormationにて`cfn.yml` を実行することで上記リソースを作成できる。

