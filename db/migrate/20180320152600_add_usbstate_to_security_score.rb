class AddUsbstateToSecurityScore < ActiveRecord::Migration[5.1]
  def change
    add_column :security_scores, :usbstate, :string
  end
end
