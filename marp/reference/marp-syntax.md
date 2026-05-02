# Marp 書式リファレンス（要点）

## 1. フロントマター

```yaml
---
marp: true
theme: custom
paginate: true        # true / false / hold / skip
size: 16:9
lang: ja
header: 'ヘッダ'      # 全スライド共通にしたいとき
footer: 'フッタ'
---
```

## 2. ディレクティブの3形態

| 形 | 適用範囲 | 例 |
|---|---|---|
| フロントマター | 全体 | `paginate: true` |
| `<!-- key: value -->` | そのスライド以降 | `<!-- header: 'X' -->` |
| `<!-- _key: value -->` | **そのスライドのみ** | `<!-- _class: title -->` |

`<!--- ... --->`（ハイフン3本）は無効。

## 3. スライド区切り

- `---`（前後に空行を入れると安全）
- `___` `***` `- - -` も可

## 4. 画像構文（alt にキーワード）

```markdown
![w:300](x.png)           <!-- 幅 -->
![h:200](x.png)           <!-- 高さ -->
![bg](hero.jpg)           <!-- 全面背景 -->
![bg left:40%](hero.jpg)  <!-- 左40% -->
![bg](a.jpg)              <!-- 並列背景 -->
![bg](b.jpg)
![bg 60%](x.jpg)          <!-- サイズ指定 -->
```

## 5. 数式・コード

- インライン: `$x^2$`
- ブロック:

```markdown
$$
\int_0^1 x\,dx = \tfrac{1}{2}
$$
```

- コードはフェンスド `` ```lang ... ``` ``。インラインコードに改行を詰めない。

## 6. 自動縮小（Marp Core 限定）

```markdown
# <!--fit--> 大きく見せたい見出し
```

## 7. 箇条書きのフラグメント表示

- `-` で始める → 一度に表示
- `*` で始める → クリックごとに1項目ずつ表示

## 8. スピーカーノート

```markdown
# 公開スライド

<!--
ここは発表者にだけ見えるメモ。
-->
```

## 9. ビルドコマンド

```bash
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf slides.md
marp --theme-set ~/.claude/skills/marp/themes/custom.css -w slides.md   # 監視
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pptx slides.md
```

ローカル画像を埋めるとき: `--allow-local-files` を追加。

## 10. よくある間違い

- ❌ `<!--- _class: title --->`（ハイフン3本）→ ✅ `<!-- _class: title -->`
- ❌ `class: lead` をフロントマターに書きつつ表紙だけ別クラスにしようとする
- ❌ コードをバッククォート1個でくるむ → ✅ フェンスドコード
- ❌ 表紙の縦位置を `<br>` 連打で調整 → ✅ CSS の Flex（テーマ側で対応済み）
- ❌ md に CSS をコピー / 相対パス参照 → ✅ `--theme-set` で Skill 側を指す

## 11. 多段組みレイアウト（FlexBox）

`<div class="flex …">` で段組を実現する。`_class` は使わない。

### クラス一覧

| クラス | 効果 | 用途 |
|---|---|---|
| `flex` | `display: flex; gap: 1em` | 基本の横並び |
| `flex sa` | `justify-content: space-around` | 等間隔配置（2段・3段） |
| `flex sb` | `justify-content: space-between` | 両端揃え（2段） |
| `flex fw` | 子 `<div>` に `flex: var(--fw)` | 幅比率を `--fw` で指定 |

### 2段組み（等幅）

```markdown
<div class="flex sb">

<div>

### 左カラム

- 項目A

</div>

<div>

### 右カラム

- 項目B

</div>

</div>
```

### 2段組み（幅比率指定）

```markdown
<div class="flex fw">

<div style="--fw: 3;">

### 左：3 の幅

</div>

<div style="--fw: 2;">

### 右：2 の幅

</div>

</div>
```

### 3段組み

```markdown
<div class="flex sa">

<div>

### 左

</div>

<div>

### 中央

</div>

<div>

### 右

</div>

</div>
```

### 空行ルール（必須）

- `<div>` タグの**直前直後は必ず空行**を入れる
- タグが文字としてそのまま出力される場合 → 空行が足りない

## 12. 任意文字色

### CSS クラス（推奨）

```markdown
<span class="c-accent">アクセント色</span>
<span class="c-ng">エラー色</span>
<span class="h-yellow">黄色マーカー</span>
```

| クラス | 色 | 用途 |
|---|---|---|
| `c-accent` | `--color-accent` (#4488cc) | 強調 |
| `c-primary` | `--color-primary` (#5e80ad) | 本文強調 |
| `c-heading` | `--color-heading` (#224466) | 見出し色 |
| `c-ok` | #2e8b57 | 成功・OK |
| `c-warn` | #d2691e | 警告 |
| `c-ng` | #c0392b | エラー・NG |
| `c-mute` | #8899aa | 補足・ミュート |
| `h-yellow` | 背景 #fff3a3 | 黄色マーカー |
| `h-blue` | 背景 `--color-accent-soft` | 青マーカー |
| `h-pink` | 背景 #ffd7e0 | ピンクマーカー |

### `<font color>` （局所限定で許可）

```markdown
<font color="tomato">一発色変え</font>
```

- CSS 名前付き色: `tomato`, `steelblue`, `darkgreen` 等（[MDN 一覧](https://developer.mozilla.org/ja/docs/Web/CSS/Reference/Values/named-color)）
- 16進: `#ff6347`
- RGB: `rgb(255, 99, 71)`
- HSL: `hsl(9, 100%, 64%)`
- 新色を頻繁に使うなら `custom.css` にクラス追加を検討

## 13. Mermaid 図

Marp 内で Mermaid 図を描画するには、Mermaid.js を HTML 注入で読み込む。

### スクリプトの挿入（フロントマター直後）

```html
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
```

### 図の書き方

```html
<div class="mermaid">
graph TD
  A[ユーザー] --> B[Marp]
  B --> C[(PDF/HTML)]
</div>
```

**重要**: ` ```mermaid ``` ` フェンスドコードではなく `<div class="mermaid">…</div>` で囲むこと。
Marp はフェンスドコードを `<pre><code>` に変換するため、Mermaid.js が拾えない。

### 出力制限

- **HTML 出力（`--html`）でのみ描画される**（ブラウザで Mermaid.js が走るため）。
- PDF/PPTX 出力では Mermaid.js が走らないため図が描画されないことが多い。
- ビルド時は `--html` フラグで HTML パススルーを許可すること:

```bash
# HTML 出力（Mermaid 推奨）
marp --theme-set ~/.claude/skills/marp/themes/custom.css --html slides.md

# PDF 出力（図が描画されないことがある）
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf --html slides.md
```

### よくある間違い

- ❌ ` ```mermaid ``` ` フェンスドコードで書く → ✅ `<div class="mermaid">…</div>` で囲む
- ❌ `--html` フラグなしでビルドする → ✅ `--html` を付けて HTML パススルーを許可する

## 14. 同梱 README

スライド骨子を生成する際、`templates/README.md.tpl` の `{{SLIDE_FILE}}` を実際のファイル名に置換し、
生成物と同じディレクトリに `README.md` として書き出す。

- 既に `README.md` が存在する場合は**上書きせず**、差分箇所のみ追記提案する
- スライド本体の最後に「ビルド方法は同階層の `README.md` を参照」と1行添える
