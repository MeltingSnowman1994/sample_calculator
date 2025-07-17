Flutter × Bloc パターンで実装したシンプルな電卓アプリです。  
本プロジェクトは以下の Zenn 記事の解説用サンプルとして作成されました。

📘 [Flutterで学ぶ詳細設計と実装](https://zenn.dev/your-article-url-here)

---

## 🧭 概要

このアプリは、以下の学習目的を意識して設計されています。

- 小規模なアプリでも設計の重要性を実感する
- Blocパターンを使ってUIとロジックを分離する
- 単体テストが可能な構造を実現する
- 状態遷移を意識した実装に慣れる

**責務分離 → 設計 → 実装 → テスト** の一連の流れを通して、実践的な設計手法を学べます。

---

## 🗂 ディレクトリ構成

lib/
├── main.dart // アプリのエントリポイント
├── ui/ // UI関連
│ ├── calculator_page.dart // ページ構成
│ ├── calculator_view.dart // UIと状態の描画
│ └── calculator_button.dart // ボタン部品
└── bloc/
└── calculator_bloc.dart // Bloc本体（イベント・状態・ロジック）

test/
└── calculator_bloc_test.dart // Blocのテストコード
