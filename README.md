データベース設計

##messages_table

|column    |type      |                 |
|:--------:|:--------:|:---------------:|
|body      |text      |null:false       |
|image     |string    |null:false       |
|group_id  |          |foreign_key: true|
|user_id   |          |foreign_key: true|
|timestamps|          |null:false       |

belongs_to: :user
belongs__to: :group

##users_table

|column               |type      |           |
|:-------------------:|:---------|:--------- |
|name                 |string    |null:false |
|Email                |string    |unique:true|
|Password             |stirng    |null:false |
|password_comformation|string    |null:false |
|timestamps           |          |null:false |

has_many: groups, through: :users_groups
has_many: users_groups
has_many: messages


##groups_table

|column    |type      |           |
|:--------:|:--------:|:---------:|
|group_name|string    |null:false |

has_many: users, through: :users_groups
has_many: user_groups
has_many:messages

##users_groups_table

|column    |type      |                  |
|:--------:|:--------:|:----------------:|
|user_id   |          |foreign_key: true |
|group_id  |          |foreign_key: true |

belongs_to: user
belongs_to: group
