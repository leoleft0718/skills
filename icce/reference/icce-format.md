# ICCE 2026 フォーマット要件 — LaTeX 設定対応表

ICCC_requirement.md の要件を LaTeX 設定に対応付けた参照表。

## 1. ページサイズ・余白

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| 用紙サイズ | A4 | `\documentclass[11pt,a4paper]{article}` |
| 上余白 | 1 inch (2.54 cm) | `geometry` の `top=1in` |
| 下余白 | 0.8 inch (2.03 cm) | `geometry` の `bottom=0.8in` |
| 左右余白 | 各 1 inch (2.54 cm) | `geometry` の `left=1in, right=1in` |
| ヘッダー・フッター領域 | なし | `geometry` の `nohead, nofoot` |

## 2. フォント・行間

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| フォント | Arial | `\usepackage{fontspec}` + `\setmainfont{Arial}` |
| 本文サイズ | 11 pt | `\documentclass[11pt,...]{article}` |
| 行間 | シングル | `\usepackage{setspace}` + `\setstretch{1.0}` |
| 本文揃え | 両端揃え (justified) | デフォルト |

## 3. 段落

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| 段落インデント | 1.25 cm | `\setlength{\parindent}{1.25cm}` |
| 段落間の空行 | なし | `\setlength{\parskip}{0pt}` |
| 見出し直後の段落 | インデントなし | LaTeX デフォルト動作 |

## 4. タイトルページ

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| タイトル前の空行 | 1 行 | `\vspace{\baselineskip}` |
| タイトルフォント | 22 pt 太字 | `\fontsize{22pt}{26pt}\selectfont\bfseries` |
| タイトル揃え | 中央揃え | `\begin{center}...\end{center}` |
| タイトル後の空行 | 1 行 | `\vspace{\baselineskip}` |
| 著者名の姓 | 大文字 | 直接 `LAST NAME` と大文字で記述 |
| 所属 | 斜体 | `\textit{...}` |
| 著者情報後の空行 | 1 行 | `\vspace{\baselineskip}` |

## 5. Abstract と Keywords

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| 冒頭ラベル | **Abstract:** (太字) | `\textbf{Abstract:}` |
| フォントサイズ | 10 pt | `\small` (10pt 相当) |
| 左右インデント | 各 0.5 inch (1.27 cm) | `\setlength{\leftmargin}{0.5in}` 等 |
| 語数制限 | 350 語以内 | 手動確認 |
| Keywords ラベル | **Keywords:** (太字) | `\textbf{Keywords:}` |
| Keywords 書式 | Abstract と同じ | 同環境を再利用 |
| Keywords 後の空行 | 2 行 | `\vspace{2\baselineskip}` |

## 6. 見出し・小見出し

| 要件 | 第1階層 (section) | 小見出し (subsection) |
|---|---|---|
| 番号 | 1, 2, 3, … | 1.1, 1.2, 2.1, … |
| 書体 | **太字** | *斜体* |
| 揃え | 左揃え | 左揃え |
| 前の空行 | 2 行 | 1 行 |
| 後の空行 | 1 行 | 1 行 |
| LaTeX 設定 | `titlesec`: `\bfseries`, spacing `2\baselineskip`/`\baselineskip` | `titlesec`: `\itshape`, spacing `\baselineskip`/`\baselineskip` |

## 7. 図表

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| 番号付け | セクション別でなく通し番号 | デフォルト |
| 配置 | 初出箇所の近く | `[htbp]` |
| 図キャプション | 図の**下**、中央揃え | `\captionsetup[figure]{position=below, justification=centering}` |
| 表キャプション | 表の**上**、斜体左揃え | `\captionsetup[table]{position=above, justification=raggedright}` |
| キャプション前後の空行 | 各1行 | `\vspace{\baselineskip}` |
| 画像プレースホルダー | — | `% FIGURE HERE: <説明>` コメント |

## 8. 参考文献

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| スタイル | APA 7th edition | `\usepackage[style=apa,backend=biber]{biblatex}` |
| 見出し | References | `\printbibliography[title={References}]` |
| 本文引用 | `Author (Year)` または `(Author, Year)` | `\textcite{key}` / `\parencite{key}` |

## 9. ページ番号・ヘッダー・フッター

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| ページ番号 | なし | `\pagestyle{empty}` |
| ヘッダー・フッター | なし | `geometry` の `nohead, nofoot` |

## 10. アクセシビリティ

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| PDF ブックマーク | あり | `\usepackage{bookmark}` + `hyperref` の `bookmarks=true` |
| Alt-text | すべての図に | キャプションで代替 |

## 11. その他

| 要件 | 値 | LaTeX 設定 |
|---|---|---|
| Acknowledgements | References の前 | `\section*{Acknowledgements}` |
| 単一盲査 | 匿名化不要 | 著者名・所属・メールを記載 |
