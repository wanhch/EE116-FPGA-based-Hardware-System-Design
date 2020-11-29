# 报告
## 问题与解决方法:
* 128bit AES加密需要执行10轮加密并且最后一轮与之前不一样： 使用loop generect例化其中的重复部分，并在开头与结尾加入循环之外的部分。  
* SBox中的constan较多且在密钥生成与SubByte过程中都需要使用： 将SBox写入package中供程序调用。  
* Mix Columns中的乘法为新定义乘法： 在package中实现gmult()函数供程序调用。