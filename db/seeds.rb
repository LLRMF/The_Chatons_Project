
require 'faker'

# Supprime tous les utilisateurs et articles existants

# Crée 5 utilisateurs avec des adresses e-mail aléatoires et un mot de passe par défaut
# Création des utilisateurs
# 5.times do
#   user = User.create(
#     email: Faker::Internet.email(domain: 'yopmail.com'),
#     password: "mdp1234"
#   )
# end

image_urls = [
  'https://img.freepik.com/photos-gratuite/gros-plan-chatons-explorant-nature_23-2150782397.jpg?w=2000&t=st=1701343677~exp=1701344277~hmac=b05f8976d68b7296c7717d620f950156850500428d689ac42f540b458e5d8439',
  'https://img.freepik.com/photos-gratuite/chaton-mignon-assis-dans-herbe-regardant-camera-curiosite-generee-par-intelligence-artificielle_25030-63219.jpg?w=2000&t=st=1701344950~exp=1701345550~hmac=b1feb50b05b8341681c443e0d1344dce3e87445b149c8c47b93015177bdca5c3',
  'https://img.freepik.com/photos-gratuite/capture-ecran-adorable-chaton-assis-canape_181624-46615.jpg?t=st=1701343665~exp=1701344265~hmac=689cf76b3cafd15d5fe6141f174e114cdc98f0f3f299e72565c24ca1aa687312',
  'https://img.freepik.com/photos-gratuite/gros-plan-deux-jeunes-chats-calins-ensemble-coin-mur-pierre_181624-17362.jpg?w=1800&t=st=1701345033~exp=1701345633~hmac=2ce89a4548827517653b5e8abece0e842a276b3aac4485dbabc7f873408f8814',
  'https://img.freepik.com/photos-gratuite/cinq-petits-chatons-gris-se-trouvent-tapis-rose_8353-7262.jpg?w=1800&t=st=1701345055~exp=1701345655~hmac=953c7fd415b603a8d4d441e8c4becc57a60f2c854000737ea3b2a962158071e0',
  'https://img.freepik.com/photos-gratuite/vue-adorable-chaton_23-2150886364.jpg?w=1800&t=st=1701345076~exp=1701345676~hmac=64d7574834d4f904b0844c91d21d16d7f46d9f8cf0ff752e6b7eb12b0165be20',
  'https://img.freepik.com/photos-gratuite/gros-plan-chaton-dans-feuilles-automne_23-2150782305.jpg?w=2000&t=st=1701345109~exp=1701345709~hmac=d9d357364bc365db56d55c3087eaf273f069be9af3113182090f009448403c53',
  'https://img.freepik.com/photos-gratuite/bouchent-portrait-beau-chat_23-2149214419.jpg?w=1800&t=st=1701345132~exp=1701345732~hmac=5c8819dd2e394b63b0980c8b6bcff4e52961a6b2c541fdff7a6c839eac6ca632',
  'https://img.freepik.com/photos-gratuite/vue-adorable-chaton_23-2150886402.jpg?w=2000&t=st=1701345168~exp=1701345768~hmac=fc5ba53e1454dd3897a3e38c2e2ab86c1fb3647e3811bb89f5e258a24145fbf9',
  'https://img.freepik.com/photos-gratuite/chaton-mignon-marchant-dehors_23-2150752844.jpg?w=2000&t=st=1701345194~exp=1701345794~hmac=cfe036dabeb0f2f56932e74b17072fb73baba8835fcbe3a43f2a6995e3fe64bd',
  'https://img.freepik.com/photos-gratuite/mignon-chaton-gingembre-maine-coon-est-allonge-meubles-speciaux-pour-chat_613910-20322.jpg?w=1800&t=st=1701345225~exp=1701345825~hmac=11da89f9b5de1a8f9e4a0bffb144568c63b638046f24b11b8d1b3cede5f9651f',
  'https://img.freepik.com/photos-gratuite/gros-plan-chaton-gris-nature_167946-121.jpg?w=1800&t=st=1701345249~exp=1701345849~hmac=0ce0bf8f22883232f362b89af378e8cff5949bf8c2263051b971100fdece5370',
  'https://img.freepik.com/photos-gratuite/adorable-minou-qui-air-vouloir-chasser_23-2149167044.jpg?w=740&t=st=1701345271~exp=1701345871~hmac=6e3ba9a8c6ad707925607ff30dcd1a0e8ee427079e3c23d8a504f7457e6670a5',
  'https://img.freepik.com/photos-gratuite/chaton-mignon-du-fil-au-crochet-interieur_23-2150752792.jpg?w=2000&t=st=1701345318~exp=1701345918~hmac=3aa1e5befb2c9e69a080305097478397791690b5175733b848f3e8bff7b8b4f3',
  'https://img.freepik.com/photos-gratuite/adorable-chaton-lunettes-soleil_23-2150886406.jpg?w=2000&t=st=1701345349~exp=1701345949~hmac=22ccb86629da19290c493cf4a76104b10e253e18cda9b75e0e5510c9a8d0477a',
  'https://img.freepik.com/photos-gratuite/gros-plan-chaton-sa-langue-isolee-mur-blanc_181624-6725.jpg?w=1800&t=st=1701345381~exp=1701345981~hmac=ebe6a75c591f90238e9b30670d1ad597434e48bc0dd136df47e91d43f7b5e4b0',
  'https://img.freepik.com/photos-gratuite/chaton-moelleux-se-blottit-chiot-endormi-choye-genere-par-ia_188544-29097.jpg?w=2000&t=st=1701345408~exp=1701346008~hmac=46638b1b01f7875c26597cbbe31d105365fc445cd4dbfedbf118bcce4ae869dc',
  'https://img.freepik.com/photos-gratuite/capture-ecran-mignon-petit-chaton-noir-blanc-dans-panier-du-textile-vert_181624-53490.jpg?w=1800&t=st=1701345442~exp=1701346042~hmac=b10449abda2c2e31b4b7785ca3df56578ed304533e72b354abb3ab0516181b29',
  'https://img.freepik.com/photos-gratuite/beau-chaton-fleurs-exterieur_23-2150752812.jpg?t=st=1701345377~exp=1701345977~hmac=2b97ee0702a7b2b0345954676b62df92359538cc2a06abc30c765c8f7bcf1f3d',
  'https://img.freepik.com/photos-gratuite/beau-chaton-fleurs-interieur_23-2150752846.jpg?w=1060&t=st=1701345535~exp=1701346135~hmac=acf4a60bddde5212391f9f4d188e3f7dd93b86b7f12661ab241fcfa937279367',
].shuffle

# Création de 20 articles aléatoires
items = []
20.times do
  item = Item.create(
    title: Faker::Superhero.power,
    description: Faker::Lorem.characters(number: 100, min_alpha: 4),
    price: Faker::Number.decimal(l_digits: 2),
    image_url: image_urls.pop,
  )
  items << item  # Stocke les articles créés dans un tableau
end

User.create(email: 'admin@admin.com', password: 'mdp1234', admin: true)
