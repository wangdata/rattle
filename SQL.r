### 让R语言能够读写SQL Server里的数据
library(RODBC)
# 这里是载入RODBC库

channel <- odbcConnect("MyTestODBC")
# 连接刚才添加进数据源的“MyTestODBC”数据库

# ch <- odbcConnect("some dsn", uid = "user", pwd = "****")
# 表示用户名为user，密码是****，如果没有设置，可以直接忽略

data(USArrests)
# 将“USArrests”表写进数据库里（这个表是R自带的）

sqlSave(channel, USArrests, rownames = "state", addPK = TRUE)
# 将数据流保存，这时候打开SQL Server就可以看到新建的USArrests表了

rm(USArrests)
sqlTables(channel)
# 给出数据库中的表

sqlFetch(channel, "USArrests", rownames = "state")
# 输出USArrests表中的内容

sqlQuery(channel, "select * from USArrests")

sqlDrop(channel, "USArrests")
# 删除表

odbcClose(channel)
# 最后要记得关闭连接

# ------------------------------------------------------------------
### 通过RODBC从Oracle读取数据
# 加载RODBC包
library(RODBC)

# 创建连接
channel <- odbcConnect("MySQLTest", uid = "root", pwd = "19910303")

# 执行查询
org1 <- sqlFetch(channel, 'sakila.city')
org2 <- sqlQuery(channel, 'SELECT * FROM sakila.city')

# 关闭连接
odbcClose(channel)

# 使用数据
head(org1)
head(org2)

# ------------------------------------------------------------------
### 通过RODBC将数据写入Oracle
library(RODBC)
channel <- odbcConnect("MySQLTest")

# 创建数据框（待写入对象）
mydata <- sqlQuery(channel,'SELECT * FROM world.city')

# 写入数据库表，并读取结果表
sqlSave(channel, mydata[1:50,], 'world_city', append = FALSE)
mydata2 <- sqlQuery(channel, 'SELECT * FROM world_city')

# 更新数据库表，并读取数据
# sqlSave(channel, mydata, 'NEW_TABLE_NAME', append = TRUE)
# mydata3 <- sqlQuery(channel, 'SELECT * FROM NEW_TABLE_NAME')   

# 删除刚刚建立的表
sqlDrop(channel, 'world_city')
odbcClose(channel)

# 查看执行结果
head(mydata, n = 10)
head(mydata2, n = 10)

# ------------------------------------------------------------------
library(RMySQL)
con <- dbConnect(MySQL(), user = "root", password = "19910303", dbname = "test")
res <- dbSendQuery(con, "SELECT * FROM world.city")
dat <- fetch(res)
head(dat)
tail(dat)
dbDisconnect(con)
