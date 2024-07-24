---
title: 無名関数にジェネリック型を追加する方法
tags:
  - TypeScript
private: false
updated_at: '2024-07-25T08:18:04+09:00'
id: 78dc99b54da528b07a1d
organization_url_name: null
slide: false
ignorePublish: false
---

## ジェネリック型の必要性

特にデータのコレクション（配列など）を扱う場合、任意のタイプのデータを変換できる関数を持つことが一般的です。この種の関数を汎用的に保ち、型を維持するためには、ジェネリック型を使用する必要があります。

## ジェネリック型を持つ無名関数の書き方

無名関数がジェネリック型で動作するためには、ジェネリック型のシグネチャで始める必要があります。

```typescript
<T>() => {}
```

これを踏まえて、型`T`の配列を受け取り、そのコレクションに対して何らかの操作を行い、型`T`の配列を返す関数を書くことができます。

## ジェネリック型を使用した例

例えば、配列から最初の`n`要素を取り出し、それを返す関数は以下のようになります。

```typescript
const take = <T>(arr: Array<T>, n: number): Array<T> => {
  return arr.slice(0, n);
}
```

この関数は、配列の型を強制しつつ保持します。例として、Prismaクエリから取得する特定の型を持つ複雑なオブジェクトが含まれる配列などの状況に対してもうまく機能します。

## フリーランスエンジニア必見！

最後に、フリーランスエンジニアの方にご案内です。
あなたに今だけご紹介できる”エンド直”・”高単価”の案件があります！

気になる方は公式ラインの追加をお願いします👇
https://s.lmes.jp/landing-qr/2005758918-ADDegZkx?uLand=tau44P