ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :username
    column :first_name
    column :last_name
    column :admin
    column :email
    column :sign_in_count
    column :created_at
    column :confirmed_at
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :username
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :password_confirmation
      f.input :confirmed_at
      f.input :confirmation_sent_at
      f.input :confirmation_token
      f.input :unconfirmed_email
      f.input :locale
      f.input :admin
    end
    f.actions
  end

end
