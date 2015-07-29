shared_examples 'to action' do |action|
  responds 302

  it action do
    expect(response).to redirect_to action: action
  end
end

shared_examples :template do |template, options|
  renders [template], options
end
shared_examples :templates do |templates, options|
  renders templates, options
end

shared_examples :unprocessable_entity do |options|
  responds 422
end

shared_examples :not_found do |options|
  responds 404
end

shared_examples :unauthorized do |options|
  responds 401
end

shared_examples :bad_request do |options|
  responds 400
end

shared_examples :redirecting do |options|
  responds 302
end

shared_examples :success do |options|
  responds 200
end

shared_examples :ok do |options|
  responds 200
end

def renders templates, options
  describe 'renders templates' do
    [templates].flatten.each do |view|
      it { expect(response).to render_template view }
    end
  end

  if options && options.is_a?(Hash)
    if options[:layout]
      describe 'renders using layout' do
        it { expect(response).to render_template layout: "layouts/#{options[:layout]}" }
      end
    end
  end
end

def responds status
  it "(#{status})" do
    expect(response.status).to be status
  end
end
