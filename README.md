# lastpass_wrapper

## これは何
パスワードのコピーを省力化するツールです。  
Mac環境しか考慮していません。  

デフォルトで5秒後にクリップボードを1つ前の内容に戻します。  
簡易に書いているので、連続した操作などがあると、この部分はうまく動かない事があります。  

## 使用方法
lastpassの公式cliツールlpassをラップしていますので、インストールが必要です。  
https://github.com/lastpass/lastpass-cli#installing-on-os-x

以下のようにシンボリックリンクをはって、リンクネームで使用します。  
適宜、~/bin/などに入れて使用します。  
```
ln -s lastpass_wrapper.sh lpw
ln -s lastpass_wrapper.sh lun
ln -s lastpass_wrapper.sh lst
ln -s lastpass_wrapper.sh lli
ln -s lastpass_wrapper.sh llo
```
上から順に、パスワード取得・ID取得・ログイン状態確認・ログイン・ログアウトです。  
ログインの為に、スクリプト内のMY_IDを編集する必要があります。  
lpass自体の処理で再ログイン時は自動的にアカウントを指定してくれるので、設定しなくても使う事はできます。  

以下、使用例です。  
「web_login」の部分でlastpassに登録しているサイト名(タイトル名)を指定します。  
aオプションはパイプ用です。  
```
$ lun -a web_login
vg-ss
$ 

$ lpw web_login
  Info: Copyied to clipboard.
$ 
```
