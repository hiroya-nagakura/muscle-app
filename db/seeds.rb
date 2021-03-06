# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
TargetSite.create!(muscle_name: '胸')
TargetSite.create!(muscle_name: '肩')
TargetSite.create!(muscle_name: '腕')
TargetSite.create!(muscle_name: '腹')
TargetSite.create!(muscle_name: '背中')
TargetSite.create!(muscle_name: '脚')
TagGroup.create!(name: '筋肉')
TagGroup.create!(name: '器具')
TagGroup.create!(name: 'オススメ')
TagGroup.create!(name: 'その他')
Tag.create(name: '大胸筋', tag_group_id: 1)
Tag.create(name: '三角筋', tag_group_id: 1)
Tag.create(name: '上腕二頭筋', tag_group_id: 1)
Tag.create(name: '上腕三頭筋', tag_group_id: 1)
Tag.create(name: '腹直筋', tag_group_id: 1)
Tag.create(name: '腹斜筋', tag_group_id: 1)
Tag.create(name: '僧帽筋', tag_group_id: 1)
Tag.create(name: '広背筋', tag_group_id: 1)
Tag.create(name: '大臀筋', tag_group_id: 1)
Tag.create(name: '大腿四頭筋', tag_group_id: 1)
Tag.create(name: 'ハムストリング', tag_group_id: 1)
Tag.create(name: '下腿二頭筋', tag_group_id: 1)
Tag.create(name: '自重', tag_group_id: 2)
Tag.create(name: 'ダンベル', tag_group_id: 2)
Tag.create(name: 'バーベル', tag_group_id: 2)
Tag.create(name: 'ベンチ', tag_group_id: 2)
Tag.create(name: 'チューブ', tag_group_id: 2)
Tag.create(name: 'マシン', tag_group_id: 2)
Tag.create(name: '初心者', tag_group_id: 3)
Tag.create(name: '中級者', tag_group_id: 3)
Tag.create(name: '上級者', tag_group_id: 3)
Tag.create(name: 'どなたでも', tag_group_id: 3)
Tag.create(name: 'ダイエット', tag_group_id: 3)
Tag.create(name: 'バルクアップ', tag_group_id: 3)
Tag.create(name: '家トレ', tag_group_id: 4)
Tag.create(name: 'ジム', tag_group_id: 4)
Tag.create(name: 'コラム', tag_group_id: 4)
Tag.create(name: 'ストレッチ', tag_group_id: 4)
Tag.create(name: 'パワーリフティング', tag_group_id: 4)
Tag.create(name: 'ストリートワークアウト', tag_group_id: 4)


