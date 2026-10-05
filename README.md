# 取引先管理システム（Simple B2B Contact Manager）

Java 法人研修 章 7「チーム開発課題」のベースリポジトリです。
営業担当が、取引先企業（Company）とその担当者（Contact）を管理するシステムを、チームで作り上げます。

タスクの一覧と進め方は、カリキュラムの 7.1〜7.5 を参照してください。

## 技術スタック

| 種類 | 内容 |
| --- | --- |
| 言語 | Java 21 |
| フレームワーク | Spring Boot 4.1（Spring MVC / Spring Data JPA / Thymeleaf / Validation） |
| データベース | PostgreSQL |
| マイグレーション | Flyway |
| 画面 | Bootstrap 5 |

## セットアップ

### 1. リポジトリをクローンする

```
git clone https://github.com/（講師から案内された組織名）/simple-contact-manager.git
cd simple-contact-manager
```

### 2. データベースを作成する

DBeaver で PostgreSQL に接続し、`contact_manager` という名前のデータベースを作成します。

```sql
CREATE DATABASE contact_manager;
```

テーブルとサンプルデータは、アプリの初回起動時に自動で作成されます（Flyway）。

### 3. DB のパスワードを設定する

`src/main/resources/application-local.yml.example` をコピーして、同じフォルダに
`application-local.yml` という名前で保存します。中の `password` を、PostgreSQL を
インストールしたときに自分で決めたパスワードに書き換えてください。

```yaml
spring:
  datasource:
    password: 自分のパスワード
```

`application-local.yml` は `.gitignore` に入っているので、Git にはコミットされません。
パスワードをチームのリポジトリに載せないための仕組みです。

### 4. アプリを起動する

IntelliJ でこのフォルダを開き、右サイドバーの Gradle から `Tasks → application → bootRun` を実行します。
ターミナルから起動する場合は次のコマンドです。

```
./gradlew bootRun
```

### 5. 動作確認

ブラウザで http://localhost:8080 を開き、「セットアップ完了です」と表示されれば成功です。

DBeaver で `contact_manager` データベースを開くと、`companies`（5 件）と `contacts`（25 件）の
サンプルデータが入っています。

## 最初から用意されているもの

| ファイル | 内容 |
| --- | --- |
| `src/main/java/com/contactmanager/entity/Company.java` | 取引先企業のエンティティ |
| `src/main/java/com/contactmanager/entity/Contact.java` | 取引先担当者のエンティティ |
| `src/main/resources/db/migration/V1__create_companies.sql` | `companies` テーブルの作成 |
| `src/main/resources/db/migration/V2__create_contacts.sql` | `contacts` テーブルの作成 |
| `src/main/resources/db/migration/V3__insert_sample_data.sql` | サンプルデータの登録 |
| `src/main/resources/static/index.html` | 起動確認用の仮のトップページ（タスク 15 で削除する） |

Controller / Service / Repository / 画面（テンプレート）は入っていません。タスクで作っていきます。

## フォルダ構成（作っていく場所）

```
src/main/java/com/contactmanager/
├── controller/   … Controller（タスクで作成）
├── service/      … Service（タスクで作成）
├── repository/   … Repository（タスクで作成）
├── form/         … フォームの入力値を受け取るクラス（タスクで作成）
└── entity/       … エンティティ（Company / Contact は用意済み）

src/main/resources/
├── templates/
│   ├── companies/   … Company の画面（list.html / new.html など）
│   └── contacts/    … Contact の画面
└── db/migration/    … テーブル定義を変更する SQL
```

## テーブル定義を変更するとき

このプロジェクトでは、テーブルの作成・変更を `db/migration/` の SQL ファイルで管理しています（Flyway）。

- すでにあるファイル（V1〜V3）は **書き換えない**。変更したいときは新しいファイルを追加する
- エンティティを変更したら、対応するマイグレーションも必ず追加する
  （一致していないと、起動時にエラーになります）

### ファイル名の付け方

新しく追加するファイルは、バージョンの部分を **作成した日時（年月日時分秒の 14 桁）** にします。

```
V20261003143000__add_company_id_to_contacts.sql
 └ 2026年10月03日 14時30分00秒
```

`V4`、`V5` のような連番にすると、2 人が別々のブランチで同じ番号を使ってしまい、
マージ後にアプリが起動しなくなります。日時にしておけば番号が重なりません。

詳しくはカリキュラムの 5.28 を参照してください。

## 開発の流れ

1. Issue に自分をアサインする
2. `main` を最新にして、`feature/task-XX-短い説明` の名前でブランチを作る
3. 実装して、こまめにコミットする
4. タスクの完了条件をすべて満たしたら、`main` への PR を作成する
5. 1 名以上の承認（Approve）が付いたらマージする

詳しくはカリキュラムの 7.2 を参照してください。
