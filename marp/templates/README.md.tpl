# {{SLIDE_FILE}}

## ビルド

```bash
# プレビュー（保存で自動更新）
marp --theme-set ~/.claude/skills/marp/themes/custom.css -w {{SLIDE_FILE}}

# PDF 書き出し
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pdf {{SLIDE_FILE}}

# PPTX 書き出し
marp --theme-set ~/.claude/skills/marp/themes/custom.css --pptx {{SLIDE_FILE}}
```

ローカル画像を埋め込む場合は `--allow-local-files` を末尾に付ける。

---

## 多段組みの使い方

### 2段組み（等幅・両端揃え）

```markdown
<div class="flex sb">

<div>

### 左

- 項目A

</div>

<div>

### 右

- 項目B

</div>

</div>
```

- `sb` = space-between（両端揃え、2段用）
- `sa` = space-around（等間隔、3段用）
- `<div>` の**直前直後は必ず空行**（空行がないとタグがそのまま表示される）

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

### 幅比率を指定（3:2 など）

```markdown
<div class="flex fw">

<div style="--fw: 3;">

### 幅3

</div>

<div style="--fw: 2;">

### 幅2

</div>

</div>
```

`--fw` の数値の比で幅が決まる。`1:1` なら `--fw: 1` / `--fw: 1`。

### 画像＋テキストのレイアウト

```markdown
<div class="flex fw">

<div style="--fw: 3;">

![キャプション](./image.png)

</div>

<div style="--fw: 2;">

### 見出し

- 説明テキスト

> 補足

</div>

</div>
```

---

## 文字色の使い方

### マーカー（`em` が最も手軽）

```markdown
*青マーカー*  ← em（太字＋青背景）。最もよく使う強調。
<span class="h-yellow">黄色マーカー</span>
<span class="h-pink">ピンクマーカー</span>
```

重要なキーワード・結論・注意点には必ずマーカーを引く。

### プリセットクラス（推奨）

```markdown
<span class="c-ok">成功</span>
<span class="c-ng">エラー</span>
<span class="h-yellow">黄色マーカー</span>
```

| クラス | 色 | 用途 |
|---|---|---|
| `c-accent` | 青 #4488cc | 強調 |
| `c-primary` | 紺 #5e80ad | 本文強調 |
| `c-heading` | 濃紺 #224466 | 見出し色 |
| `c-ok` | 緑 #2e8b57 | 成功・OK |
| `c-warn` | 橙 #d2691e | 警告 |
| `c-ng` | 赤 #c0392b | エラー・NG |
| `c-mute` | 灰 #8899aa | 補足 |
| `h-yellow` | 背景黄 | ハイライト |
| `h-blue` | 背景青 | ハイライト |
| `h-pink` | 背景ピンク | ハイライト |

### 一発色変え

```markdown
<font color="tomato">トマト色</font>
```

色名は [MDN named-color](https://developer.mozilla.org/ja/docs/Web/CSS/Reference/Values/named-color) のほか、`#ff6347` や `rgb(255,99,71)` も可。

---

## トラブル時

| 症状 | 原因 | 解決 |
|---|---|---|
| 段組が効かない | `<div>` の前後に空行がない | 空行を入れる |
| タグが文字として出る | 同上 | 空行を入れる |
| PDF で日本語が出ない | Noto Sans JP 読み込み失敗 | ネット環境を確認 |
| `custom` テーマが認識されない | `--theme-set` 忘れ | コマンドに `--theme-set ~/.claude/skills/marp/themes/custom.css` を付ける |
