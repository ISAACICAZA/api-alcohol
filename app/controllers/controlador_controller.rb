class ControladorController < ApplicationController
    require 'net/http'
    require 'json'

    def index
        url = URI.parse('https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list&l=es')
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
    
        request = Net::HTTP::Get.new(url.request_uri)
    
        response = http.request(request)
    
        if response.code == '200'
            data = JSON.parse(response.body)
            @categorias = data['drinks'].map { |drink| drink['strCategory'] }
            # 'categorias' se convierte en una variable de instancia para que esté disponible en la vista
        else
            # Manejar errores de solicitud aquí si es necesario
            puts "Error al obtener datos. Código de respuesta: #{response.code}"
        end
    end

    def cat
        @categoria = params[:categoria].to_s
        url = URI.parse("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=#{@categoria}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
    
        request = Net::HTTP::Get.new(url.request_uri)
    
        response = http.request(request)

        if response.code == '200'
            @dat = JSON.parse(response.body)
            @cat = @dat['drinks'].map { |drink| [drink['strDrink'], drink['strDrinkThumb'], drink['idDrink']] }
        else
            # Manejar errores de solicitud aquí si es necesario
            puts "Error al obtener datos. Código de respuesta: #{response.code}"
        end
    end

    def detalles 
        id_t = params[:id_trago].to_s  
        idioma= "l=es"
        url = URI.parse("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?#{idioma}&i=#{id_t}")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == 'https')
    
        request = Net::HTTP::Get.new(url.request_uri)
    
        response = http.request(request)
    
        if response.code == '200'
            @detalle_trago = JSON.parse(response.body)
        else
            # Manejar errores de solicitud aquí si es necesario
            puts "Error al obtener datos. Código de respuesta: #{response.code}"
        end
    end

    
    def search
        if params[:name].present?
          @name = params[:name]
          url = URI.parse("https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{@name}")
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true if url.scheme == 'https'
          request = Net::HTTP::Get.new(url)
          response = http.request(request)
    
          if response.code == "200"
            data = JSON.parse(response.body)
            @cocteles = data["drinks"]
          else
            flash[:error] = "Error en la solicitud a la API"
            @cocteles = []
          end
        else
          flash[:error] = "Ingrese un nombre de cóctel para buscar"
          @cocteles = []
        end
      end
end
