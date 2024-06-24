---
createdAt: 2024-06-24
title: 'Linux で点字の表示がおかしいときの対処法'
tags: ['archlinux', 'linux']
---

## はじめに
どうもこんにちは。n4mlz です。  
ブログを自作したはいいものの記事を全く書いていなかったのでもったいないと思い、今記事を書いています。
今回は私が以前 Linux を使用していて困ったこととその解決方法を書いてみました。

## 困ったこと

![スクリーンショット](/src/content/posts/images/linux-braille/screenshot1.png)

これは私のスクリーンショットの一部です。Linux の TUI ではこのように点字を使ってグラフや画像を表現することがありますが、上の画像のように点字が上手く表示できていません。これを直します。

## 原因の特定
以下のコマンドで、U+2802 (⠂、点字文字の一つ) を持つフォント一覧を取得します。

```bash
fc-list :charset=2802
```

また、以下で点字フォントを実際に表示しているフォントを確認できます。

```bash
FC_DEBUG=4 pango-view --font="monospace" -t "⠂" | grep family:
```

私の場合は、どうやら `gnu-free-fonts` というフォントが悪さをしているらしいということがわかりました。

## 解決方法

`gnu-free-fonts` を削除して、かわりに点字フォントを想定通りに表示できるフォント (`ttf-symbola`) をインストールします。
パッケージマネージャはお使いのディストリビューションに合わせて適宜変更してください。

```bash
sudo pacman -Rs gnu-free-fonts
yay -S ttf-symbola
```

reboot して、再度点字を表示してみると、想定通りの表示になっていることがわかります。

![スクリーンショット](/src/content/posts/images/linux-braille/screenshot2.png)

## おわりに
今回は Linux で点字の表示がおかしいときの対処法について書いてみました。誰かの役に立てれば幸いです。
