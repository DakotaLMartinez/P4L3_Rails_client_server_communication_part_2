# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(username: 'Dakota', email: 'dakota@dakota.com', bio: 'i love ruby')
user2 = User.create(username: 'DJ', email: 'dj@dj.com', bio: 'i love js')

group = Group.create(name: 'SENG-080921', location: 'everywhere!')

event = user.created_events.create(
  group: group,
  title: 'Rails Fundamentals',
  description: 'migrations generators and fun!',
  start_time: Time.new(2021, 10, 12, 11),
  end_time: Time.new(2021, 10, 12, 13)
)

event.attendees = [user, user2]