require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:user) { User.create!(name: "Admin", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", role: 2, confirmed_at: Date.today) }
  let(:user2) { User.create!(name: "Sam", email: "Blocipedia2@bloc.com", password: "password2", password_confirmation: "password2", role: 0, confirmed_at: Date.today) }
  let(:user3) { User.create!(name: "Premium", email: "Blocipedia3@bloc.com", password: "password3", password_confirmation: "password3", role: 1, confirmed_at: Date.today) }
  let(:my_wiki) { Wiki.create!(title: "New Wiki", body: 'Wiki Body', user: user, private: true, collaborator_email: "test@gmail.com", collaborator_drop: "test2@gmail.com") }
  let(:my_wiki_public) { Wiki.create!(title: "New Wiki2", body: 'Wiki Body2', user: user2, private: false) }
  let(:my_wiki_private) { Wiki.create!(title: "New Wiki3", body: 'Wiki Body3', user: user3, private: true) }


  before :each do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end

  end


  describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end


      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end


      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end


    describe "Wiki create" do

      it "increases the number of Wiki by 1" do
        expect{post :create, wiki: {title: "New Wiki", body: 'Wiki Body', user: user}}.to change(Wiki,:count).by(1)
      end


      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: "New Wiki", body: 'Wiki Body', user: user, private: true, collaborator_email: "test@gmail.com", collaborator_drop: "test2@gmail.com"}
        expect(assigns(:wiki)).to eq Wiki.last
      end


      it "redirects to the wiki index" do
        post :create, wiki: {title: "New Wiki", body: 'Wiki Body', user: user, private: true, collaborator_email: "test@gmail.com", collaborator_drop: "test2@gmail.com"}
        expect(response).to redirect_to wikis_path
      end
    end


  describe "GET show" do
       it "returns http success" do
         get :show, {id: my_wiki.id}
         expect(response).to have_http_status(:success)
       end

       it "renders the #show view" do
         get :show, {id: my_wiki.id}
         expect(response).to render_template :show
       end

       it "assigns my_wiki to @wiki" do
         get :show, {id: my_wiki.id}
         expect(assigns(:wiki)).to eq(my_wiki)
       end
     end


describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_wiki.id}
      expect(response).to render_template :edit
    end


    it "assigns wiki to be updated to @wiki" do
      get :edit, {id: my_wiki.id}

      wiki_instance = assigns(:wiki)
      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
    end

  end


describe "PUT update" do

     it "updates wiki with expected attributes" do

       new_title = "Second Wiki"
       new_body = "Second Wiki text for body"

       put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

       updated_wiki = assigns(:wiki)
       expect(updated_wiki.id).to eq my_wiki.id
       expect(updated_wiki.title).to eq new_title
       expect(updated_wiki.body).to eq new_body

     end

     it "redirects to the wiki index" do
       new_title = "Second Wiki"
       new_body = "Second Wiki text for body"

       put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
       expect(response).to redirect_to wikis_path
     end
   end


describe "DELETE destroy" do

     it "deletes the wiki" do
       delete :destroy, {id: my_wiki.id}
       count = Wiki.where({id: my_wiki.id}).size
       expect(count).to eq 0
     end

     it "redirects to wikis index" do
       delete :destroy, {id: my_wiki.id}
       expect(response).to redirect_to wikis_path
     end
   end

####

context "standard user" do

  before :each do
    sign_in user2


  describe "GET show" do
       it "returns http success" do
         get :show, {id: my_wiki_public.id}
         expect(response).to have_http_status(:success)
       end

       it "renders the #show view" do
         get :show, {id: my_wiki_public.id}
         expect(response).to render_template :show
       end

       it "renders the #edit view for public wiki" do
         get :edit, {id: my_wiki_public.id}
         expect(response).to render_template :edit
       end

       it "renders the #edit view for private wiki" do
         get :edit, {id: my_wiki_private.id}
         expect(assigns(:user_id)).to eq(user2)
       end
     end
  end
end


  context "Premium user" do

    before :each do
      sign_in user3

    describe "GET show" do
         it "returns http success" do
           get :show, {id: my_wiki_public.id}
           expect(response).to have_http_status(:success)
         end

         it "renders the #show view" do
           get :show, {id: my_wiki_public.id}
           expect(response).to render_template :show
         end

         it "renders the #edit view for public wiki" do
           get :edit, {id: my_wiki_public.id}
           expect(response).to render_template :edit
         end

         it "renders the #edit view for private wiki" do
           get :edit, {id: my_wiki_private.id}
           expect(response).to render_template :edit
         end
       end
    end
  end

end
