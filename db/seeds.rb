user1 = User.create! email: 'ich@du.de', password: 'gehheim'
user2 = User.create! email: 'du@ich.de', password: 'gehheim'

action = Category.create! name: 'Action'
syfy = Category.create! name: 'Science Fiction'
romance = Category.create! name: 'Romance'

batman = Movie.create! title: 'Batman', text: 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.', category: action
superman = Movie.create! title: 'Superman', text: 'An alien orphan is sent from his dying planet to Earth, where he grows up to become his adoptive home\'s first and greatest super-hero.', category: syfy
Movie.create! title: 'Cheech and Chong', text: 'Two stoners unknowingly smuggle a van - made entirely of marijuana - from Mexico to L.A., with incompetent Sgt. Stedenko on their trail.', category: action
Movie.create! title: 'Naked Gun 2 1/2', text: 'Lieutenant Drebin discovers that his ex-girlfriend\'s new beau is involved in a plot to kidnap a scientist who advocates solar energy.', category: nil
Movie.create! title: 'Bad Ass', text: 'A Vietnam veteran who becomes a local hero after saving a man from attackers on a city bus decides to take action when his best friend is murdered and the police show little interest in solving the crime.', category: nil
Movie.create! title: 'Indiana Jones and the Last Crusade', text: 'When Dr. Henry Jones Sr. suddenly goes missing while pursuing the Holy Grail, eminent archaeologist Indiana Jones must follow in his father\'s footsteps and stop the Nazis.', category: nil
Movie.create! title: 'You, Me and Dupree', text: 'A best man (Wilson) stays on as a houseguest with the newlyweds, much to the couple\'s annoyance.', category: romance
Movie.create! title: 'Star Wars', text: 'Luke Skywalker, a spirited farm boy, joins rebel forces to save Princess Leia from the evil Darth Vader, and the galaxy from the Empire\'s planet-destroying Death Star.', category: syfy
Movie.create! title: 'Star Trek', text: "When a destructive space entity is spotted approaching Earth, Admiral Kirk resumes command of the Starship Enterprise in order to intercept, examine and hopefully stop it.", category: syfy
Movie.create! title: 'Keinohrhasen', text: "Rainbow press reporter Ludo is sentenced to 8 months, but is released on probation. But he has to work 300 hours for a local daycare center and meets Anna who has unfinished business with him.", category: romance
Movie.create! title: 'Lord of the Rings', text: "A meek hobbit of The Shire and eight companions set out on a journey to Mount Doom to destroy the One Ring and the dark lord Sauron.", category: nil
Movie.create! title: 'Memento', text: "A man, suffering from short-term memory loss, uses notes and tattoos to hunt for the man he thinks killed his wife.", category: nil
Movie.create! title: 'Pulp Fiction', text: "The lives of two mob hit men, a boxer, a gangster's wife, and a pair of diner bandits intertwine in four tales of violence and redemption.", category: nil


Rating.create! user: user1, movie: batman, number: 5
Rating.create! user: user2, movie: batman, number: 3
Rating.create! user: user1, movie: superman, number: 1
Rating.create! user: user2, movie: superman, number: 1
