create_table 'events', force: :cascade, collation: 'utf8mb4_general_ci' do |t|
  t.string 'token',       null: false
  t.date   'event_date',  null: false

  t.timestamps
end

add_index 'events', 'token', unique: true, using: :btree
