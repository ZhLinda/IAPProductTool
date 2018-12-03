# IAPProductTool
批量上传 iOS 内购商品信息。

## 准备工作

安装 Xcode 工具： `xcode-select --install`

安装 fastlane： `[sudo] gem install fastlane -NV`

安装 spaceship：`[sudo] gem install spaceship`

安装 roo：`[sudo] gem install roo`

根目录下创建 res。

在 res 目录下创建自定义文件夹，用来存放应用信息，目录结构如下：

![001.png](/screenshot/001.png)

在 config.json 填写你的开发者账号和应用的 bundle id 。

![002.png](/screenshot/002.png)

在 product.xlsx 填上商品信息。

![003.png](/screenshot/003.png)

注：product.xlsx 的商品信息格式要按照范例的格式来填写。

id：商品id，只填写 product id 的后面一段，脚本会自动在前面加上 bundle id 。例如 ：表格里面 id 填写 'store.1'，应用 bundle id 为 'com.xxx.shsg'，上传的 product id 实际为 'com.xxx.shsg.store.1' 。

name：商品名称。

amount：商品价格，人民币，元。

desc：商品描述，10个字以上。

review_desc：审核备注。

review_image：审核商品快照名称。快照为 750 × 1334 jpg 格式，放在 res 的应用目录下。

status：0 代表执行，1 代表跳过

## 使用

创建商品：

在第一次上传商品时使用。

```
ruby index.rb shsg create
```

修改商品：

在 product.xlsx 的商品信息有修改时使用（product id 无法修改）

```
ruby index.rb shsg modify
```

第一个参数为 res 下的应用目录名。

第二个参数为 create | modify 。

注：第一次运行脚本时可能会让你输入开发账号的密码。

## 遇到的问题

1.

```
error=ITC.response.error.IAP_CREATION_NOT_ALLOWED
```

发现是因为 itunesconnect 的条款没有更新，登录到 itunesconnect 更新下条款就可以了。



