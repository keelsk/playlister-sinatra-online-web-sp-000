require 'pry'
class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    @artists = Artist.all
    erb :'songs/new'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song.artists = Artist.find_or_create_by(params[:artist]) if !params[:artist][:name].empty?
    @song.genres << Genre.find_or_create_by(params[:genre]) if !params[:genre][:name].empty?
    @song.save
    flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    @artists = Artist.all
    erb :'songs/edit'
  end

  patch '/songs' do
    binding.pry
    @song = Song.find_by_slug(params[:slug])
    @new_song = @song.update(params[:song])
    @new_song.artist = Artist.find_or_create_by(params[:artist]) if !params[:artist][:name].empty?
    @new_song.genres << Genre.find_or_create_by(params[:genre]) if !params[:genre][:name].empty?
    @new_song.save
    # flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@new_song.slug}")
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    erb :'songs/show'
  end

end
