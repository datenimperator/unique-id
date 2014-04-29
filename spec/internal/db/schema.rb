ActiveRecord::Schema.define do
  create_table(:unique_ids, id:false, force:true) do |t|
    t.string :type, default:nil, null:false
    t.string :scope
    t.integer :value, default:nil, null:false
  end
  add_index :unique_ids, [:type, :scope, :value], unique: true
end
