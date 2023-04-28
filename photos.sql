-- chatGPT 生成
-- 删除名为 time_period 的表（如果它已经存在），然后创建一个新的 time_period 表
DROP TABLE IF EXISTS time_period;
-- 创建名为 time_period 的数据表
CREATE TABLE IF NOT EXISTS time_period (
  id INTEGER PRIMARY KEY,
  period VARCHAR(255) NOT NULL -- '时间段'
);

-- 删除名为 characters 的表（如果它已经存在），然后创建一个新的 characters 表
DROP TABLE IF EXISTS characters;
-- 创建名为 characters 的数据表
CREATE TABLE IF NOT EXISTS characters (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL -- '人物名称'
);

-- 删除名为 tags 的表（如果它已经存在），然后创建一个新的 tags 表
DROP TABLE IF EXISTS tags;
-- 创建名为 tags 的数据表
CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL -- '标签名称'
);

-- 删除名为 media 的表（如果它已经存在），然后创建一个新的 media 表
DROP TABLE IF EXISTS media;
-- 创建名为 media 的数据表
CREATE TABLE IF NOT EXISTS media (
  file_name VARCHAR(255) NOT NULL PRIMARY KEY,
  file_path VARCHAR(255) NOT NULL, -- '文件路径（取值强制检查必须是YYYYMM格式）'
  file_md5 VARCHAR(32) NOT NULL, -- '文件md5'
  file_size INTEGER UNSIGNED NOT NULL, -- '文件大小'
  timestamp INTEGER UNSIGNED NOT NULL, -- '时间戳'
  country VARCHAR(255) NOT NULL, -- '国家'
  province VARCHAR(255) NOT NULL, -- '省份'
  city VARCHAR(255) NOT NULL, -- '城市'
  time_period_id INTEGER NOT NULL, -- '时间段id'
  duration INTEGER UNSIGNED NOT NULL, -- '时长'
  FOREIGN KEY (time_period_id) REFERENCES time_period(id)
);

-- 删除名为 media_characters 的表（如果它已经存在），然后创建一个新的 media_characters 表
DROP TABLE IF EXISTS media_characters;
-- 创建名为 media_characters 的数据表
CREATE TABLE IF NOT EXISTS media_characters (
  media_id INTEGER NOT NULL, -- '媒体资源id',
  character_id INTEGER NOT NULL, -- '人物id',
  PRIMARY KEY (media_id, character_id),
  FOREIGN KEY (media_id) REFERENCES media(id),
  FOREIGN KEY (character_id) REFERENCES characters(id)
);

-- 删除名为 media_tags 的表（如果它已经存在），然后创建一个新的 media_tags 表
DROP TABLE IF EXISTS media_tags;
-- 创建名为 media_tags 的数据表
CREATE TABLE IF NOT EXISTS media_tags (
  media_id INTEGER NOT NULL, -- '媒体资源id',
  tag_id INTEGER NOT NULL, -- '标签id',
  PRIMARY KEY (media_id, tag_id),
  FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- 向 time_period 表中插入预定义的时间段记录
INSERT INTO time_period (period) VALUES 
  ('小时候'),
  ('幼儿园'),
  ('小学'),
  ('初中'),
  ('高中'),
  ('大学'),
  ('上班');

-- 插入预定义的标签记录
INSERT INTO tags (name) VALUES 
  ('旅游'),
  ('美食'),
  ('运动'),
  ('音乐'),
  ('电影');
