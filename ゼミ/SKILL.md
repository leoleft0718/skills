---
name: ゼミ
description: 高木正則研究室のゼミ用スライドを Marp Markdown で作成する。表紙→ミニコーナー→前回との接続→目次・サマリー→本文→まとめの固定構成を前提に、ゼミごとに変わる本文部分をユーザーの指示に基づいて生成する。
---

# ゼミスライド作成スキル

高木正則研究室のゼミ用スライドを **Marp Markdown** (`theme: custom`) で生成する。
Marp スキル（`~/.claude/skills/marp/`）のテーマ・書式ルールを継承し、
ゼミ特有の**固定構成**をテンプレートとして提供する。

## いつ使うか

- ユーザーが「ゼミ」「ゼミスライド」「ゼミ資料」と言ったとき
- ゼミ用の進捗報告スライドを作成・修正したいとき

## 入力形式

Markdown（`.md`）・HTML（`.html` / `.htm`）のいずれでも入力可能。
HTML 入力時のパース・画像抽出・スライド分割は **Marp スキルの「入力形式」セクション** のルールに従う。

## スライド固定構成

ゼミスライドは以下の**固定4スライド**から始まり、その後にゼミごとの本文が続く。

| 順序 | スライド | テンプレート | 内容 |
|---|---|---|---|
| 1 | 表紙 | `templates/title.md` | タイトル・氏名・所属 |
| 2 | 今日のミニコーナー | `templates/mini-corner.md` | 冒頭の軽いトピック |
| 3 | 前回と今回のつながり | `templates/connection.md` | 前回の振り返り→今回の位置づけ |
| 4 | 目次・サマリー | `templates/toc-summary.md` | 今日の報告の全体像 |

**5枚目以降**はゼミごとに変更する本文スライド。`templates/content.md`・`templates/two-column.md` を雛形に章ごとに書く。最後に `templates/references.md` で参考文献一覧スライドを置く。

## 厳守ルール

Marp スキルの厳守ルールをすべて継承する。追加で以下を守ること。

1. **固定4スライドの順序・構成を崩さない**
   - 表紙 → ミニコーナー → 前回と今回のつながり → 目次・サマリーの順序は変更しない。
   - 各スライドのヘッダー名も固定（`今日のミニコーナー`、`前回と今回のつながり`、`目次・サマリー`）。

2. **フロントマター・ディレクティブは Marp スキルに準拠**

```yaml
---
marp: true
theme: custom
paginate: true
---
```

3. **表紙は Spot Local で `_class: title`・`_paginate: false`**

4. **「前回と今回のつながり」スライドは前回ゼミとの接続を明示**
   - 前回の主要な報告・結論・課題と、今回の継続点・新規内容を対比させる。

5. **「目次・サマリー」は本文スライドの構成に合わせて更新**
   - 本文スライドを書き終えた後に、目次のセクション名と概要を本文と整合させる。

6. **参考文献はフッターに IEEE 形式で引用する**
   - 本文スライドで文献を参照する箇所には **[1]**, **[2]** のようにインライン番号を振る。
   - そのスライドの `<!-- _footer: '...' -->` に参照文献をカンマ区切りで列挙する。
   - **フッター値はシングルクォートで囲むこと**（論文タイトル内の `"..."` と二重引用符が競合してフッターが反映されなくなるため）。
   - フッターの書式は IEEE 形式に従う:
     - 論文: `[1] A. Author, B. Author, "Title," *Journal*, vol. X, no. Y, pp. Z1–Z2, Year.`
     - 書籍: `[1] A. Author, *Title*, Publisher, Year, pp. X–Y.`
     - 会議: `[1] A. Author, "Title," in *Proc. Conf.*, Year, pp. X–Y.`
   - スライド末尾に **参考文献一覧スライド** を置き、全文献を IEEE 形式でまとめる。
   - 番号はスライドファイル内で通し番号とする（スライドごとにリセットしない）。

   **記述例**:
   ```markdown
   <!-- _header: 提案手法 -->

   # 提案手法の概要

   - 従来法 [1] の問題点を解消する新しいアーキテクチャを提案
   - 損失関数には [2] と同様の定式化を採用

   <!-- _footer: '[1] A. Smith et al., "Baseline," *IEEE Trans.*, vol.10, pp.1–5, 2024.&#10;[2] B. Lee, "Loss Design," in *Proc. CVPR*, 2023, pp.100–110.' -->
   ```

## ユーザー情報（表紙に自動反映）

- 氏名: 三浦翔大
- 所属: 情報理工学研究科情報学専攻
- 研究室: 高木正則研究室

ユーザーが別の所属を指定した場合はそちらを優先する。

## 生成手順（モデル向け）

### 共通手順

1. 入力ファイルの形式（`.md` / `.html` / `.htm`）を判定する。
2. ユーザーの要望と入力内容から本文スライドの構成（章立て）を決める。
3. `templates/title.md` を表紙として配置（氏名・所属は上記をデフォルトで反映）。
4. `templates/mini-corner.md` でミニコーナースライドを配置。
5. `templates/connection.md` で前回と今回のつながりスライドを配置。
   - ユーザーが前回の内容を指定しない場合はプレースホルダーを残す。
6. `templates/toc-summary.md` で目次・サマリースライドを配置。
7. 本文スライドは `templates/content.md` を雛形に章ごとに書く。
   - 2カラムが必要なら `templates/two-column.md` を使う。
8. 本文を書き終えた後、目次・サマリーの内容を本文と整合させる。
9. 本文スライドのインライン引用番号とフッターの対応をチェックする。
10. 末尾に参考文献一覧スライドを配置する。
11. `paginate` / `_paginate: false` の整合をチェックする。
12. **変更後は必ず PDF エクスポートを実行する**。
13. ユーザーにビルドコマンドを提示する。

## ビルドコマンド

スライド md に CSS パスを書かない。Marp スキルのテーマを `--theme-set` で渡す。

```bash
# プレビュー（監視モード）
marp --theme-set ~/.claude/skills/marp/themes/custom.css -w slides.md

# PDF
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf slides.md

# PPTX
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pptx slides.md

# HTML（単体配布）
marp --theme-set ~/.claude/skills/marp/themes/custom.css --html slides.md
```

ローカル画像を埋め込む PDF/PPTX の場合は `--allow-local-files` を追加する。

## 参照ファイル

- Marp 書式リファレンス → `~/.claude/skills/marp/reference/marp-syntax.md`
- テーマ仕様 → `~/.claude/skills/marp/themes/custom.css`
- ゼミ用テンプレート → `templates/`
- ゼミ用フルサンプル → `examples/seminar-sample.md`
- 参考文献テンプレート → `templates/references.md`
