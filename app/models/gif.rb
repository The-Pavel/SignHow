class Gif < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :language, presence: true
  validates :file, presence: true
  mount_uploader :file, PhotoUploader
  acts_as_favoritable


  LANGUAGES = %w[  Language
Afrikaans
Albanian
Amharic
Arabic-Egyptian
Arabic-Levantine
Arabic-Standard
Arabic-Moroccan
Aramaic
Armenian
Assamese
Aymara
Azerbaijani
Balochi
Bamanankan Bashkort Bashkir
Basque
Belarusan
Bengali
Bhojpuri
Bislama
Bosnian
Brahui
Bulgarian
Burmese
Cantonese
Catalan
Cebuano
Chechen
Cherokee
Croatian
Czech
Dakota
Danish
Dari
Dholuo
DutchEnglish
Esperanto
Estonian
Éwé
Finnish
French
Georgian
German
Gikuyu
Greek
Guarani
Gujarati
Haitian Creole
Hausa
Hawaiian
Hawaiian Creole
Hebrew
Hiligaynon
Hindi
Hungarian
Icelandic
Igbo
Ilocano
Indonesian-Bahasa
Inuit/Inupiaq
Irish Gaelic
Italian
Japanese
Jarai
Javanese
K’iche’
Kabyle
Kannada
Kashmiri
Kazakh
Khmer
Khoekhoe-Korean
Kurdish
Kyrgyz
Lao
Latin
Latvian
Lingala
Lithuanian
Macedonian
Maithili
Malagasy
Malay-Bahasa-Melayu
Malayalam
Mandarin-Chinese
Marathi
Mende
Mongolian
Nahuatl
Navajo
Nepali
Norwegian
Ojibwa
Oriya
Oromo
Pashto
Persian
Polish
Portuguese
Punjabi
Quechua
Romani
Romanian
Russian
Rwanda
Samoan
Sanskrit
SerbianShona
Sindhi
Sinhala
Slovak
Slovene
Somali
Spanish
Swahili
Swedish
Tachelhit
Tagalog
Tajiki
Tamil
Tatar
Telugu
Thai
Tibetic-languages
Tigrigna
Tok Pisin
Turkish
Turkmen
Ukrainian
Urdu
Uyghur
Uzbek
Vietnamese
Warlpiri
Welsh
Wolof
Xhosa
Yakut
Yiddish
Yoruba
Yucatec
Zapotec
Zulu
]


end
