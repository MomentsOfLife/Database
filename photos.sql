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


-- 删除名为 type 的表（如果它已经存在），然后创建一个新的 type 表
DROP TABLE IF EXISTS type;
-- 创建名为 type 的数据表
CREATE TABLE IF NOT EXISTS type (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL -- '类别名称'
);

-- 删除名为 theme 的表（如果它已经存在），然后创建一个新的 theme 表
DROP TABLE IF EXISTS theme;
-- 创建名为 theme 的数据表
CREATE TABLE IF NOT EXISTS theme (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL -- '类别名称'
);

-- 删除名为 administrative_division 的表（如果它已经存在），然后创建一个新的 administrative_division 表
DROP TABLE IF EXISTS administrative_division;
CREATE TABLE IF NOT EXISTS `administrative_division` (
  `code` TEXT NOT NULL PRIMARY KEY,
  `name` TEXT NOT NULL,
  `parent_code` TEXT NOT NULL,
  `level` INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS `idx_parent_code` ON `administrative_division` (`parent_code`);


-- 删除名为 media 的表（如果它已经存在），然后创建一个新的 media 表
DROP TABLE IF EXISTS media;
-- 创建名为 media 的数据表
CREATE TABLE IF NOT EXISTS media (
  file_name VARCHAR(255) NOT NULL PRIMARY KEY,
  file_path VARCHAR(255) NOT NULL, -- '文件路径（取值强制检查必须是YYYYMM格式）'
  file_md5 VARCHAR(32) NOT NULL, -- '文件md5'
  file_size INTEGER UNSIGNED NOT NULL, -- '文件大小'
  timestamp INTEGER UNSIGNED NOT NULL, -- '时间戳'
  position VARCHAR(255) NOT NULL, -- '国家'
  time_period_id INTEGER NOT NULL, -- '时间段id'
  duration INTEGER UNSIGNED NOT NULL, -- '时长'
  latitude REAL NOT NULL, -- '经度'
  longitude REAL NOT NULL, -- '纬度'
  media_width INTEGER, -- '宽度'
  media_height INTEGER, -- '高度'
  star INTEGER DEFAULT 1, -- '是否收藏：1 未收藏， 2收藏'
  review_type INTEGER DEFAULT 1, -- '是否Review：1 未审核， 2已审核'
  type_id INTEGER NOT NULL, -- '主题'
  privacy_level INTEGER NOT NULL CHECK (`privacy_level` BETWEEN 1 AND 4), -- '私密等级：1，仅自己可见。2，仅家人可见。3，仅朋友可见。4，所有人可见'
  FOREIGN KEY (time_period_id) REFERENCES time_period(id),
  FOREIGN KEY (type_id) REFERENCES type(id),
  FOREIGN KEY (position) REFERENCES administrative_division(code),
);
CREATE INDEX IF NOT EXISTS `idx_timestamp` ON `media`(`timestamp`);

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

-- 删除名为 media_theme 的表（如果它已经存在），然后创建一个新的 media_theme 表
DROP TABLE IF EXISTS media_theme;
-- 创建名为 media_theme 的数据表
CREATE TABLE IF NOT EXISTS media_theme (
  media_id INTEGER NOT NULL, -- '媒体资源id',
  media_theme_id INTEGER NOT NULL, -- '主题id',
  PRIMARY KEY (media_id, media_theme_id),
  FOREIGN KEY (media_id) REFERENCES media(id),
  FOREIGN KEY (media_theme_id) REFERENCES theme(id)
);

-- 向 time_period 表中插入预定义的时间段记录
INSERT INTO time_period (period) VALUES 
  ('小时候'),
  ('幼儿园'),
  ('小学'),
  ('初中'),
  ('高中'),
  ('大学'),
  ('爸爸上班'),
  ('爸爸带娃');

-- 插入预定义的标签记录
INSERT INTO type (name) VALUES 
  ('旅行'),
  ('日常生活'),
  ('学校日常');

INSERT INTO theme (name) VALUES 
  ('2019香格里拉'),
  ('写代码');

INSERT INTO tags (name) VALUES 
  ('自然风光'),
  ('美食'),
  ('音乐'),
  ('电影');
