---
marp: true
theme: custom
paginate: true
---

<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>

<!-- _class: title -->
<!-- _paginate: false -->

# **Sample Template**
<br>


###### 三浦翔大
###### 情報理工学研究科情報学専攻
###### 高木正則研究室

---

<!-- _header: Typography -->

# H1 ABCDE abcde
## H2 ABCDE abcde
### H3 ABCDE abcde
#### H4 ABCDE abcde

通常テキスト。**太字は青**で *em は青マーカー* になる。

<!-- footer: © 2026 Miura -->

---

<!-- _header: Lists / Math / Code -->

1. **Bold bold bold**
2. *Italic italic italic*
3. 数式

$$
\int^2_0 (x+1)\,dx = \left[\tfrac{1}{2}x^2 + x\right]^2_0 = 4
$$

4. コード

```c
#include <stdio.h>
int main() {
  printf("Hello, World!");
  return 0;
}
```

---

<!-- _header: Two Column -->

![bg left:40%](https://picsum.photos/800/1000)

# 2カラムレイアウト

- 左 = 背景画像（`bg left:40%`）
- 右 = 通常 Markdown
- 画像のサイズ・配置は **alt テキスト**で制御

---

<!-- _header: Table -->

| 項目 | 値 | 備考 |
|---|---|---|
| 太字 | **bold** | アクセント青 |
| em | *italic* | 青マーカー |
| 数式 | $E=mc^2$ | mjx-container 青 |

---

<!-- _header: Two Column (FlexBox) -->

# 2段組み比較

<div class="flex sb">

<div>

### 従来手法

- 手動で問題を作成
- 時間がかかる
- 難易度にばらつき

</div>

<div>

### 提案手法

- LLM で自動生成
- RAG で精度を担保
- 難易度を制御可能

</div>

</div>

---

<!-- _header: Three Column (FlexBox) -->

<div class="flex sa">

<div>

### 設計

- アーキテクチャ
- DB 設計

</div>

<div>

### 実装

- フロントエンド
- バックエンド

</div>

<div>

### 評価

- ユーザテスト
- A/B テスト

</div>

</div>

---

<!-- _header: Text Colors -->

# 文字色プリセット

- <span class="c-accent">c-accent</span> — 強調
- <span class="c-primary">c-primary</span> — 本文強調
- <span class="c-heading">c-heading</span> — 見出し色
- <span class="c-ok">c-ok</span> — 成功
- <span class="c-warn">c-warn</span> — 警告
- <span class="c-ng">c-ng</span> — エラー
- <span class="c-mute">c-mute</span> — 補足

# ハイライト

- <span class="h-yellow">h-yellow</span> — 黄色マーカー
- <span class="h-blue">h-blue</span> — 青マーカー
- <span class="h-pink">h-pink</span> — ピンクマーカー
- <font color="tomato">font color="tomato"</font> — 一発色変え

---

<!-- _header: Mermaid Diagram -->

# Mermaid 図の例

<div class="mermaid">
graph TD
  A[ユーザー] --> B[Marp]
  B --> C[(PDF)]
  B --> D[(HTML)]
  B --> E[(PPTX)]
</div>
