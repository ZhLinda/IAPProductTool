# IAPProductTool
批量上传 iOS 内购商品信息。

## 准备工作

安装 Xcode 工具： `xcode-select --install`

安装 fastlane： `[sudo] gem install fastlane -NV`

根目录下创建 res。

在 res 目录下创建自定义文件夹，用来存放应用信息，目录结构如下：

![001.png](/screenshot/001.png)

在 config.json 填写你的开发者账号和应用的 bundle id 。

![002.png](/screenshot/002.png)

在 product.xlsx 填上商品信息。

![003.png](/screenshot/003.png)

表格里 id 只填写 product id 的后面一段，脚本会自动在前面加上 bundle id 。

例如 ：表格里面 id 填写 'store.1'，应用 bundle id 为 'com.xxx.shsg'，上传的 product id 实际为 'com.xxx.shsg.store.1' 。

## 使用

创建商品：
```
ruby index.rb shsg create
```

修改商品：
```
ruby index.rb shsg modify
```

第一个参数为 res 下的应用目录名。

第二个参数为 create | modify 。



