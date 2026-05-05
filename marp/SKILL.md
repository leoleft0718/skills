---
name: marp
description: Marp Markdown でプレゼン資料を作成・修正するときに使う。theme: custom を前提に、表紙・本文・2カラム・コードブロック・数式・Mermaid 図を含むスライドを生成し、PDF/PPTX/HTML への書き出しコマンドまで提示する。
---

# Marp スライド作成スキル

このスキルは **Marp Markdown** で `theme: custom` を使ったスライドを書くためのもの。
書式リファレンスは `reference/marp-syntax.md`、テーマは `themes/custom.css`、
スニペットは `templates/`、フルサンプルは `examples/sample.md` を参照すること。

## いつ使うか
- ユーザーが「marp」「スライド」「プレゼン」「発表資料」「.md でスライド」と言ったとき
- 既存の `.md` を Marp で整形・修正したいと言ったとき

## 入力形式

ユーザーは以下のいずれかの形式で入力を提供する。

### Markdown 入力

Markdown ファイル（`.md`）またはプレーンテキストで内容を指定する。
従来通りスライドを生成する。

### HTML 入力

HTML ファイル（`.html` / `.htm`）が入力として提供された場合、以下の処理を行う。
想定する主な形式は **Notion の HTML エクスポート**。

#### 1. HTML のパースと Markdown 変換

Notion エクスポート特有の構造を適切に処理する。

| HTML 要素 | Markdown 変換 |
|---|---|
| `<h1 class="page-title">` | ページタイトル（表紙のタイトルに使用） |
| `<h2>` | スライドの区切り `---` ＋ `## 見出し` |
| `<h3>` | 小見出し `###`（スライド内分割が必要な場合のみ `---` を挟む） |
| `<p>` | 段落テキスト |
| `<ul><li>` | 箇条書き `-` |
| `<ol><li>` | 番号付き `1.` |
| `<strong>` | `**太字**` |
| `<em>` | `*イタリック*` |
| `<blockquote>` | `> 引用` |
| `<hr>` | セクション区切り（`---` として扱う） |
| `<div style="display:contents">` ラッパー | 無視（中身だけ処理） |
| `<span class="icon">` | 絵文字としてそのまま出力 |

不要な `<div style="display:contents">` や `<span>` ラッパー、Notion の CSS クラスは
すべて無視し、中身のテキスト・構造だけを抽出する。

#### 2. 画像の抽出とスライド挿入

Notion エクスポートの画像は以下の構造で出力される:

```html
<figure class="image">
  <a href="image.png"><img src="image.png"/></a>
</figure>
```

**画像ファイルの命名規則**（ページ内の出現順に固定）:

| 枚数 | ファイル名 |
|---|---|
| 1 枚目 | `image.png` |
| 2 枚目 | `image 1.png` |
| 3 枚目 | `image 2.png` |
| n 枚目 | `image {n-1}.png` |

- `<img>` の `src` 属性からファイル名を取得する。
- 画像ファイルは **HTML ファイルと同じディレクトリ** から `Glob` で探す。
- ファイルが見つかったら Marp の画像構文で配置する:

```markdown
![bg left:40%](./image.png)
```

またはインライン配置:

```markdown
![キャプション](./image.png)
```

- 画像ファイルが見つからない場合は `![NOT FOUND: image.png]()` のように
  プレースホルダーを残し、ユーザーに報告する。

#### 3. 画像の説明文の扱い

**画像読み取りツール（`analyze_image` 等）は使用しない。**

Notion エクスポートでは、`<figure>` の直後に画像のメタ情報がリストで記載されている:

```html
<ul><li><strong>ファイル名</strong>: image.png</li></ul>
<ul><li><strong>読み取れる文字</strong>: ...</li></ul>
<ul><li><strong>内容の要約</strong>: ...</li></ul>
<ul><li><strong>研究上の意味</strong>: ...</li></ul>
<ul><li><strong>キャプション</strong>: 図1. ...</li></ul>
```

これらの情報を以下のように活用する:

- **キャプション** → 画像の `alt` テキストまたは図の説明としてスライドに配置
- **内容の要約** → 画像の横（2カラムレイアウト）または下にテキストとして記載
- **研究上の意味** → スライド内の説明文として活用
- **読み取れる文字** → 必要に応じて画像の補足として使用
- **ファイル名** → 実際のファイル探索に使用（スライドには記載しない）

#### 4. 構造からスライド分割を推定する

- `<h2>` を基本のスライド区切り（`---`）とする。
- `<h2>` 直前の `<hr>` は区切りとして扱う（`---` に変換）。
- セクション内に `<h3>` が複数ある場合、内容量に応じて `<h3>` でも分割する。
- `<hr>` だけの区切りも `---` として扱う。

## 厳守ルール（落とし穴の固定化）

1. **フロントマターは必ずこの並びから始める**

```yaml
---
marp: true
theme: custom
paginate: true
---
```

   - グローバルに `class:` を書かない（表紙クラスと衝突するため）。

2. **ディレクティブは `<!-- ... -->`（ハイフン2本）**
   - `<!--- ... --->` は無効。ただの HTML コメントとして無視される。

3. **表紙スライドは Spot Local で当てる**

```markdown
<!-- _class: title -->
<!-- _paginate: false -->
```

   - `_` 付きはそのスライドだけに適用される。

4. **ヘッダ/フッタの使い分け**
   - その回だけ → `<!-- _header: ... -->` / `<!-- _footer: ... -->`
   - 以後ずっと → `<!-- header: ... -->` / `<!-- footer: ... -->`

5. **コードはフェンスドコードで書く**（インラインコードでまとめない）

   ````markdown
   ```c
   #include <stdio.h>
   int main(){ return 0; }
   ```
   ````

6. **レイアウト調整は `<br>` で稼がない**
   - 縦中央寄せはテーマ側 `section.title` の Flex で対応済み。
   - 表紙では `<br>` 連打しない。

7. **画像のサイズ・配置は alt テキストに書く**
   - `![w:400](x.png)`、`![bg left:40%](x.jpg)` の構文を使う。

8. **数式は `$...$` / `$$...$$`**
   - 改行は数式ブロック内のみ。本文と混ぜない。

9. **多段組み・画像レイアウトは `<div class="flex …">` で統一**
   - `flex sa` / `flex sb` / `flex fw` のいずれか。
   - 画像＋テキストの2段組みには `flex fw` ＋ `style="--fw: 3;"` / `style="--fw: 2;"` で比率を指定（`![bg left:40%]` より制御しやすい）。
   - `<table>` や全角スペースで段組を再現しない。
   - `<div>` の直前直後は必ず空行。

10. **重要な部分にはマーカー・文字色で強調する**
    - `*テキスト*`（`em`）→ **青マーカー**（太字＋青背景）。最もよく使う強調。
    - `<span class="h-yellow">テキスト</span>` → 黄色マーカー。
    - `<span class="h-pink">テキスト</span>` → ピンクマーカー。
    - 重要なキーワード・結論・注意点には必ずマーカーを引くこと。
    - 任意文字色は CSS クラス（`<span class="c-…">`）が第一候補。
    - その場限りの色だけ `<font color="...">` を許可。

11. **スライド骨子の生成依頼を受けたら、必ず README.md を同梱する**
    - `templates/README.md.tpl` を読み込み、`{{SLIDE_FILE}}` を実ファイル名に置換して生成物と同じディレクトリに `README.md` として書き出す。
    - 既に `README.md` が存在する場合は**上書きせず**、差分箇所のみ追記提案する。
    - スライド本体の最後に「ビルド方法は同階層の `README.md` を参照」と1行添える。

12. **Mermaid 図は `<div class="mermaid">` で書く**（フェンスドコードを使わない）
    - Marp はフェンスドコードを `<pre><code>` に変換するため、Mermaid.js が拾えない。
    - Mermaid を使うスライド md はフロントマター直後に `<script>` タグで Mermaid.js を読み込むこと。

    ```html
    <script type="module">
      import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
      mermaid.initialize({ startOnLoad: true });
    </script>
    ```

    - 図の書き方:

    ```html
    <div class="mermaid">
    graph TD
      A[ユーザー] --> B[Marp]
      B --> C[(PDF/HTML)]
    </div>
    ```

    - **HTML 出力（`--html`）でのみ描画される**。PDF/PPTX では Mermaid.js が走らないため図が表示されないことが多い。
    - ビルド時は必ず `--html` フラグを付けて HTML パススルーを許可すること。

13. **画像読み取りツール（`analyze_image` 等）は使用しない**
    - HTML 入力の場合、画像の説明は HTML 内のテキスト（キャプション・要約等）から取得する。
    - 画像読み取り AI ツールを呼び出して画像の内容を推測してはならない。

## ユーザー情報（表紙に自動反映）

- 氏名: 三浦翔大
- 所属: 情報理工学研究科情報学専攻
- 研究室: 高木正則研究室

表紙の所属情報は特に指定がなければ上記をそのまま使う。ユーザーが別の所属を指定した場合はそちらを優先する。

## 生成手順（モデル向け）

### 共通手順

1. 入力ファイルの形式（`.md` / `.html` / `.htm` / テキスト）を判定する。
2. ユーザーの要望と入力内容からスライド構成（章立て）を決める。
3. `templates/title.md` を表紙として配置（氏名・所属は上記をデフォルトで反映）。
4. 本文スライドは `templates/content.md` を雛形に章ごとに書く。
5. 多段組みが必要なら `templates/two-column.md` / `two-column-fw.md` / `three-column.md` を使う。
6. Mermaid 図が必要なら `templates/mermaid.md` を雛形にする。フロントマター直後に `<script>` タグで Mermaid.js を読み込み、図は `<div class="mermaid">` で囲む（フェンスドコードは不可）。
7. 文字色は `themes/custom.css` のプリセット (`c-…` / `h-…`) を優先して使う。
8. **同階層に `README.md` を生成する**: `templates/README.md.tpl` の `{{SLIDE_FILE}}` を実ファイル名に置換して書き出す。既存があれば上書きしない。
9. `paginate` / `_paginate: false` の整合をチェックする。
10. **変更後は必ず PDF エクスポートを実行する**。スライド md や CSS を編集した直後に `marp --theme-set` で PDF を生成し、結果をユーザーに提示する。
11. ユーザーに **ビルドコマンド**（または `README.md` の参照）を提示する。

### HTML 入力時の追加手順

HTML ファイルが入力の場合、共通手順 1 の後に以下を実行する。

1. **テキスト構造の抽出**: `<h2>` をセクション区切りとし、各要素を Markdown に変換する。
2. **画像ファイルの探索**: `<img src="...">` からファイル名を取得し、
   HTML と同じディレクトリを `Glob` で検索して存在確認する。
3. **画像メタ情報の取得**: `<figure>` 直後のリストから
   **キャプション**、**内容の要約** 等を取得する。
4. **スライドへの画像配置**: 画像が見つかった場合、
   `flex fw` で画像＋テキストのレイアウトを組む（`--fw` で比率調整）。
   キャプションを図番号付きで添える。
5. **画像読み取りツールは呼び出さない**（説明は HTML 内のテキストで十分）。

## ビルドコマンド

スライド md に CSS パスを書かない。必ず `--theme-set` で渡す。

```bash
# プレビュー（監視モード）
marp --theme-set ~/.claude/skills/marp/themes/custom.css -w slides.md

# PDF
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf slides.md

# PPTX
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pptx slides.md

# HTML（単体配布）
marp --theme-set ~/.claude/skills/marp/themes/custom.css --html slides.md

# Mermaid 図を含む場合（HTML パススルー必須）
# HTML 出力（Mermaid 推奨）
marp --theme-set ~/.claude/skills/marp/themes/custom.css --html slides.md
# PDF 出力（Mermaid 図が描画されないことがある）
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf --html slides.md
```

- ローカル画像を埋め込む PDF/PPTX の場合は `--allow-local-files` を追加する。
- **Mermaid 図を含むスライド**は `--html` フラグが必須（HTML パススルーを許可しないと `<script>`・`<div>` がエスケープされる）。PDF/PPTX 出力では Mermaid.js が走らないため図が描画されないことが多く、HTML 出力を推奨。

## 参照ファイル

- 書式の細かい確認 → `reference/marp-syntax.md`
- テーマ仕様の確認 → `themes/custom.css`（先頭コメントに設計メモ）
- 完成形の見本 → `examples/sample.md`
