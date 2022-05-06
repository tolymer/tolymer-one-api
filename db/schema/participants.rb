create_table 'participants', force: :cascade, collation: 'utf8mb4_general_ci' do |t|
  t.bigint 'event_id', null: false
  t.string 'name',     null: false

  t.timestamps
end

add_index 'participants', 'event_id', using: :btree
