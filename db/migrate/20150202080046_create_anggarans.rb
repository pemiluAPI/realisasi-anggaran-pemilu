class CreateAnggarans < ActiveRecord::Migration
  def change
    create_table :anggarans do |t|
      t.string  :keterangan
      t.string  :pagu
      t.string  :realisasi
      t.string  :sisa
      t.string  :presentase
      t.string  :tipe
    end
  end
end
