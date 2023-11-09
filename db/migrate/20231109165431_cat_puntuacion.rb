class CatPuntuacion < ActiveRecord::Migration[7.1]
  def change
    create_table :CatPuntuacion do |t|
      t.string :nombre
      t.integer :puntuacion, default: 0
      
      t.timestamps
    end
  end
end
