# CSV Translator

[![Build](https://github.com/jacoyutorius/csv_translator/actions/workflows/aws.yml/badge.svg)](https://github.com/jacoyutorius/csv_translator/actions/workflows/aws.yml)

GithubActionsのワークフロー内でAWS SDKを利用するRubyのコードを実行するサンプル。

GithubActionsを実行する前に以下のAWSリソースを作成する必要がある。

- OidcProvider
- IAM Role
- IAM Policy

CloudFormationにて`cfn.yml` を実行することで上記リソースを作成できる。

## setup

Amazon Translateを利用するため、`aws configure` を実行してAWS認証情報の設定をする。

```
$ bundle
$ aws configure
```

## usage

```
$ ruby app.rb https://jacoyutorius-assets.s3.ap-northeast-1.amazonaws.com/public/sample.csv 1 3 4 5
```
