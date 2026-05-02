# Notion コピペテキスト → LaTeX 変換ルール

Notion からコピペしたテキストを ICCE フォーマットの LaTeX に変換する際のルール。

## 基本変換表

| Notion テキスト | LaTeX 出力 | 備考 |
|---|---|---|
| `# Heading` | `\section{Heading}` | 第1階層。太字・左揃え・前2行後1行空行はプリアンブルで自動処理 |
| `## Heading` | `\subsection{Heading}` | 第2階層。斜体・左揃え・前後1行空行はプリアンブルで自動処理 |
| `### Heading` | `\subsubsection{Heading}` | 第3階層 |
| `**bold**` | `\textbf{bold}` | |
| `*italic*` | `\textit{italic}` | Notion では `_italic_` も可 |
| `***bold italic***` | `\textbf{\textit{bold italic}}` | |
| `~~strikethrough~~` | `\sout{strikethrough}` | `ulem` パッケージが必要な場合は追加 |
| `` `inline code` `` | `\texttt{inline code}` | |
| ```` ```lang ... ``` ```` | `\begin{lstlisting}[language=lang]...\end{lstlisting}` | `listings` パッケージ |
| `[link text](url)` | `\href{url}{link text}` | `hyperref` 必須 |
| 裸のURL | `\url{https://...}` | |
| `![alt](url)` | `% FIGURE HERE: alt` | 画像は後で手動挿入 |

## リスト

### 箇条書き (bullet list)

```
- item 1
- item 2
  - nested item
```

→

```latex
\begin{itemize}
  \item item 1
  \item item 2
  \begin{itemize}
    \item nested item
  \end{itemize}
\end{itemize}
```

### 番号付きリスト (numbered list)

```
1. item 1
2. item 2
```

→

```latex
\begin{enumerate}
  \item item 1
  \item item 2
\end{enumerate}
```

### チェックリスト

Notion の `- [ ] item` / `- [x] item` は箇条書きに変換（チェック状態は無視）。

## 表

Notion の表は `tabular` に変換:

```
| Header 1 | Header 2 |
|---|---|
| Cell 1 | Cell 2 |
| Cell 3 | Cell 4 |
```

→

```latex
\begin{table}[htbp]
  \centering
  \caption{Table caption here.}
  \label{tab:label}
  \begin{tabular}{ll}
    \toprule
    Header 1 & Header 2 \\
    \midrule
    Cell 1 & Cell 2 \\
    Cell 3 & Cell 4 \\
    \bottomrule
  \end{tabular}
\end{table}
```

- `booktabs` パッケージの `\toprule`/`\midrule`/`\bottomrule` を使用
- キャプションは表の**上**（ICCE要件）
- 表番号は通し番号（自動）

## 数式

- インライン `$...$` → そのままパススルー
- ブロック `$$...$$` → そのままパススルー（LaTeX では `\[...\]` または `equation` 環境に相当するが、`$$...$$` も XeLaTeX で動作する）
- Notion の `\frac{}{}` 等の LaTeX 数式はそのまま使用可能

## 引用ブロック

```
> quoted text
```

→

```latex
\begin{quote}
quoted text
\end{quote}
```

## Notion 特有の要素

| Notion 要素 | 処理 | 備考 |
|---|---|---|
| Callout | 無視 または `\begin{quote}...\end{quote}` | 重要な注記なら引用ブロックに |
| Toggle | 本文に展開 | 折りたたみは LaTeX にない |
| Divider (`---`) | 無視 | LaTeX では水平線を使わない |
| Page link | 無視 | 外部リンクなら `\url{}` |
| Database | 表に変換 | 構造が合えば `tabular` |
| Color text | 無視 | ICCE では白黒前提 |
| Footnote | `\footnote{...}` | |
| Mermaid 図 | `% FIGURE HERE: diagram description` | 画像として後で挿入 |

## 画像の処理フロー

1. Notion コピペテキスト内の `![alt](url)` を検出
2. 画像挿入箇所にプレースホルダーコメントを生成:
   ```latex
   % FIGURE HERE: <alt text または説明>
   ```
3. ユーザーが後で画像ファイルを用意し、以下に差し替え:
   ```latex
   \begin{figure}[htbp]
     \centering
     \includegraphics[width=0.8\linewidth]{figures/fig01.png}
     \caption{Description of the figure.}
     \label{fig:01}
   \end{figure}
   ```

## 段落の処理

- 空行で区切られたテキスト → 別段落（`\parindent` で自動インデント）
- 見出し直後の段落 → インデントなし（LaTeX デフォルト）
- Notion で意図的な改行 (`Shift+Enter`) → `\\` またはそのまま（文脈判断）

## 文体チェック

変換後に以下を確認:
- 略語は初出時に展開しているか（例: RAG → Retrieval-Augmented Generation (RAG)）
- ローカル参照に説明があるか（例: "high school" → "senior high school in Japan"）
- ジェンダー中立表現を使用しているか（they, chair, staff 等）
