# CSV Translator

GithubActionsのワークフロー内でAWS SDKを利用するRubyのコードを実行するサンプル。

GithubActionsを実行する前に以下のAWSリソースを作成する必要がある。

- OidcProvider
- IAM Role
- IAM Policy

CloudFormationにて`cfn.yml` を実行することで上記リソースを作成できる。

## setup

```
$ bundle
$ aws configure
```

## usage

```
$ ruby app.rb https://cio.go.jp/sites/default/files/uploads/documents/VaccinecertFAQ.csv 1 3 4 5
```
