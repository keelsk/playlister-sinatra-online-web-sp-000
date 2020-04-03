# Add seed data here. Seed your database with `rake db:seed`

@song = Song.create(name: "Peso dance")
@genre = Genre.create(name: "pop")
@artist = Artist.create(name: "Asap Rocky")

@song.song_genres.create(genre: @genre)
@song.artist = @artist

@song.save
