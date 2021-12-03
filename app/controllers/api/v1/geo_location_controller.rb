class Api::V1::GeoLocationController < ApplicationController
    before_action :validate_parameters
  
    api :GET, '/api/v1/geoJson/lat_lng_details'
    formats ['json']
    param :lat, String, :desc =>  'Latitude of a specific location'
    param :lng, String, :desc =>  'Longitude of a specific location'
    error 200, "Success"
    error 400, "Missing parameters"
    error 500, "Server crashed"
    description <<-EOS
      == Description
      This api will accept latitude and longtitude of a particular location and return geoJson Object to the user
      by calling the OpenStreetMap APIs.

      Also if it return error it will be returend from the method and this has a before method implemented to validate the parameters

      === Sample API call URL === 
      http://localhost:3000/api/v1/geoJson/lat_lng_details?lat=51.50532341149335&lng=-0.7388305664062501

      === Sample success message from OpenStreetMap====

      {
      "place_id"=>188199403,
      "licence"=>"Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
      "osm_type"=>"way",
      "osm_id"=>367091730,
      "lat"=>"52.5944597",
      "lon"=>"39.493167400000004",
      "display_name"=>
       "4, улица Хренникова, микрорайон Елецкий, Советский округ, Lipetsk, Lipetsk Oblast, Central Federal District, 398000, Russia",
      "address"=>
       {"house_number"=>"4",
        "road"=>"улица Хренникова",
        "residential"=>"микрорайон Елецкий",
        "city_district"=>"Советский округ",
        "city"=>"Lipetsk",
        "state"=>"Lipetsk Oblast",
        "region"=>"Central Federal District",
        "postcode"=>"398000",
        "country"=>"Russia",
        "country_code"=>"ru"},
      "boundingbox"=>["52.5943263", "52.5945931", "39.4929532", "39.4933816"]
      }
     

      === Sample Error Message OpenStreetMap=== 
      {
          "error"=>{"code"=>400, "message"=>"Floating-point number expected for parameter 'lon'"}
      }

    EOS
    def index
        client = OpenStreetMap::Client.new
        response = client.reverse(format: 'json', lat: params[:lat], lon: params[:lng], accept_language: 'en')
        if response['error'].present?
            render json: {
                status: false,
                message: response['error']['message'],
                data: nil
            }, status: response['error']['code']
        else
            render json: {
                status: true,
                message: I18n.t('search.params.lat_long.success'),
                data: response
            }, status: 200
        end
    end

    private

    def valid_float?(str)
        !!Float(str) rescue false
    end

    def validate_parameters
        unless (params[:lat].present? and valid_float?(params[:lat])) or (params[:lng].present? and valid_float?(params[:lng]))
            render json: {
                status: false,
                message: I18n.t('search.params.lat_long.invalid'),
                data: nil
            }, status: 400 
        end
    end
end
  