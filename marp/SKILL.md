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

9. **多段組みは `<div class="flex …">` で統一**
   - `flex sa` / `flex sb` / `flex fw` のいずれか。
   - `<table>` や全角スペースで段組を再現しない。
   - `<div>` の直前直後は必ず空行。

10. **任意文字色は CSSクラス（`<span class="c-…">`）が第一候補**
    - その場限りの色だけ `<font color="...">` を許可。
    - 新色は既存テーマ変数を再利用してから増やす。

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

## ユーザー情報（表紙に自動反映）

- 氏名: 三浦翔大
- 所属: 情報理工学研究科情報学専攻
- 研究室: 高木正則研究室

表紙の所属情報は特に指定がなければ上記をそのまま使う。ユーザーが別の所属を指定した場合はそちらを優先する。

## 生成手順（モデル向け）

1. ユーザーの要望からスライド構成（章立て）を決める。
2. `templates/title.md` を表紙として配置（氏名・所属は上記をデフォルトで反映）。
3. 本文スライドは `templates/content.md` を雛形に章ごとに書く。
4. 多段組みが必要なら `templates/two-column.md` / `two-column-fw.md` / `three-column.md` を使う。
5. Mermaid 図が必要なら `templates/mermaid.md` を雛形にする。フロントマター直後に `<script>` タグで Mermaid.js を読み込み、図は `<div class="mermaid">` で囲む（フェンスドコードは不可）。
5. 文字色は `themes/custom.css` のプリセット (`c-…` / `h-…`) を優先して使う。
6. **同階層に `README.md` を生成する**: `templates/README.md.tpl` の `{{SLIDE_FILE}}` を実ファイル名に置換して書き出す。既存があれば上書きしない。
7. `paginate` / `_paginate: false` の整合をチェックする。
8. **変更後は必ず PDF エクスポートを実行する**。スライド md や CSS を編集した直後に `marp --theme-set` で PDF を生成し、結果をユーザーに提示する。
9. ユーザーに **ビルドコマンド**（または `README.md` の参照）を提示する。

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
