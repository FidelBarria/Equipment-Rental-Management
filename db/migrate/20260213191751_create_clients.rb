class CreateClients < ActiveRecord::Migration[8.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :cpf_cnpj
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
