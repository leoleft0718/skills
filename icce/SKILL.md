---
name: icce
description: ICCE 2026 論文を XeLaTeX + biblatex で作成する。Notion からコピペしたテキストを ICCE フォーマット準拠の LaTeX ソースに変換し、ビルドコマンドまで提示する。
---

# ICCE 2026 論文作成スキル

ICCE 2026 投稿論文を **XeLaTeX** + **biblatex (APA 7th)** で生成する。
テンプレートは `templates/icce2026.tex`、フォーマット要件は `reference/icce-format.md`、
Notion からの変換ルールは `reference/notion-to-latex.md` を参照すること。

## いつ使うか

- ユーザーが「ICCE」「論文」「paper」「ICCE論文」と言ったとき
- Notion からコピペしたテキストを ICCE フォーマットの LaTeX に変換したいとき
- 既存の ICCE 論文 (.tex) を修正したいとき

## 厳守ルール

1. **コンパイルエンジンは XeLaTeX**（Arial フォントに `fontspec` が必要）
2. **フォントは Arial**（`\setmainfont{Arial}`）
3. **余白**: top=1in, bottom=0.8in, left=1in, right=1in
4. **タイトル**: 22pt 太字中央揃え、前後に空行1行
5. **著者**: First Name LAST NAME（姓はすべて大文字）、所属は斜体
6. **Abstract**: 10pt、左右 0.5in インデント、**350語以内**、太字 "Abstract:"
7. **Keywords**: Abstract と同じ書式、太字 "Keywords:"、後に空行2行
8. **section**: 太字・左揃え・前2行後1行空行
9. **subsection**: 斜体・左揃え・前後1行空行
10. **段落インデント**: 1.25cm、段落間に空行を入れない
11. **図キャプション**: 図の下・中央揃え
12. **表キャプション**: 表の上
13. **参考文献**: APA 7th（`biblatex` style=apa, backend=biber）
14. **ヘッダー・フッター・ページ番号**: なし
15. **Acknowledgements**: References の前に番号なしセクションとして配置
16. **PDF ブックマーク**: あり（`hyperref` + `bookmark`）

## 画像の扱い

画像は後から手動で挿入する。挿入箇所には以下のプレースホルダーコメントを残す:

```latex
% FIGURE HERE: 図の説明
```

ユーザーが画像ファイルを用意したら、以下に差し替える:

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\linewidth]{figures/fig01.png}
  \caption{Figure caption here.}
  \label{fig:01}
\end{figure}
```

画像ファイルは `figures/` ディレクトリに配置する。白黒印刷でも判読可能か確認すること。

## ユーザー情報

- 氏名: Shota MIURA（三浦翔大）
- 所属: The University of Electro-Communications, Chofu, Tokyo, Japan
- 研究室: Takagi Research Lab

ユーザーが別の著者・所属を指定した場合はそちらを優先する。

## 生成手順（モデル向け）

1. ユーザーから Notion コピペテキスト（または指示）を受け取る
2. `templates/icce2026.tex` のプリアンブルをベースに新しい .tex ファイルを生成
3. Notion テキストを LaTeX に変換（変換ルールは `reference/notion-to-latex.md` 参照）
4. 画像参照は `% FIGURE HERE: <説明>` コメントに置き換え
5. .bib ファイルを生成または更新（既存のものがあれば参照）
6. ビルドコマンドを実行してコンパイル確認
7. エラーがあれば修正して再ビルド

## ビルドコマンド

```bash
# 手動ビルド（推奨: 確実に動作）
xelatex paper.tex
biber paper
xelatex paper.tex
xelatex paper.tex

# latexmk を使う場合
latexmk -pdfxe paper.tex

# 補助ファイルの削除
latexmk -c
```

`hyperref` を `bookmark` より先にロードすること（オプション衝突を防ぐため）。

## 引用コマンド

| 書式 | コマンド | 出力例 |
|---|---|---|
| Author (Year) | `\textcite{key}` | Smith and Johnson (2024) |
| (Author, Year) | `\parencite{key}` | (Smith \& Johnson, 2024) |
| 複数引用 | `\parencite{key1,key2}` | (Smith, 2024; Tanaka, 2023) |

## 参照ファイル

- ICCE フォーマット要件 → `reference/icce-format.md`
- Notion → LaTeX 変換ルール → `reference/notion-to-latex.md`
- テンプレート → `templates/icce2026.tex`
- フルサンプル → `examples/sample-paper.tex`（.bib は `examples/sample-paper.bib`）
