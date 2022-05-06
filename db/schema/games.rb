create_table 'games', force: :cascade, collation: 'utf8mb4_general_ci' do |t|
  t.bigint  'event_id', null: false

  t.timestamps
end

add_index 'games', 'event_id', using: :btree
