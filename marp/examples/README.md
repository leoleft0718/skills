# sample.md のビルド方法

このディレクトリには Marp 用のスライド md と関連ファイルが入っています。

## 必要なもの

- Node.js + `@marp-team/marp-cli` （`npm i -g @marp-team/marp-cli`）
- 共通テーマ: `~/.claude/skills/marp/themes/custom.css`

## プレビュー（保存のたびに自動更新）

```bash
marp --theme-set ~/.claude/skills/marp/themes/custom.css -w sample.md
```

ブラウザで `http://localhost:8080` 相当のローカルプレビューが開きます。

## 書き出し

| 形式 | コマンド |
| --- | --- |
| PDF | `marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf  sample.md` |
| PPTX | `marp --theme-set ~/.claude/skills/marp/themes/custom.css --pptx sample.md` |
| HTML | `marp --theme-set ~/.claude/skills/marp/themes/custom.css --html sample.md` |

ローカル画像を埋め込む場合は `--allow-local-files` を末尾に付ける。

## よく使う書式（早見表）

- 表紙スライド: 先頭に `<!-- _class: title -->` と `<!-- _paginate: false -->`
- スライド区切り: 空行を挟んだ `---`
- 多段組み: `<div class="flex sb">…</div>`（`sb` / `sa` / `fw` のいずれか）
    - `<div>` の直前直後は **必ず空行**
- 文字色プリセット: `<span class="c-accent">…</span>`
    - 候補: `c-accent` / `c-primary` / `c-heading` / `c-ok` / `c-warn` / `c-ng` / `c-mute`
    - ハイライト: `h-yellow` / `h-blue` / `h-pink`
- 一発色変え: `<font color="tomato">…</font>`

## トラブル時

- レイアウトが崩れる → `<div>` の数と空行を確認
- タグが文字として出る → タグの前後に空行を入れる
- PDF で日本語が出ない → Noto Sans JP の読み込みに失敗。ネット環境を確認

詳しい仕様は `~/.claude/skills/marp/reference/marp-syntax.md` を参照。
