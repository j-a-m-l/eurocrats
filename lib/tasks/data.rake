namespace :eurocrats do

  def filtered_data options
    require 'countries'

    full_data = ISO3166::Setup.new.data

    full_data.reduce({}) do |all, country|
      data = country.last

      eurocrats_data =  {
        # Use first names ("Venezuela"), instead of translations ("Venezuela, Bolivarian Republic of")
        name: data['names'].first,
      }

      if options[:languages]
        eurocrats_data[:languages] = data['languages'] || options[:no_language]
      end

      if options[:currency]
        eurocrats_data[:currency] = data['currency'] || options[:no_currency]
      end

      # TODO More languages
      # if options[:translations]
      #   eurocrats_data[:translations] = data['translations'][options[:language]],
      # end

      if data['eu_member']
        eurocrats_data[:eu_member] = true
      end

      if options[:vat_rates] && data[:vat_rates]
        options[:vat_rates].each do |rate|
          eurocrats_data[:vat_rates][rate] = data[:vat_rates][rate]
        end
      end

      all.merge data['alpha2'].to_sym => eurocrats_data
    end
  end

  # TODO different country codes
  # TODO translated in more than 1 language
  # TODO include uncommon VAT rates

  namespace :data do

    desc 'Generates a JSON with countries data, with their currencies and EU VAT rates for e-services'
    task :'e-service' do

      options = {
        vat_rates: ['standard'],
        # TODO filter which languages TODO with default
        languages: true,
        currency: true,
        no_currency: 'USD',
        no_language: 'en',
      }

      data = filtered_data options

      # TODO export with shorter keys "name" => "n", "languages" => "l"
      # TODO export as array

      if ARGV[1]
        File.open ARGV[1], 'w' do |file|
          file.write JSON.pretty_generate data
        end
      else
        puts data.to_json
      end
    end

  end
end
