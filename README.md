# Japanese Address Parsing

`"東京都西多摩郡秋多町"` ->
`{"prefecture"=>"東京都", "gun"=>"西多摩郡", "municipality"=>"秋多町"}`

This repo aims to do two things:

1. Using machine learning algorithm CRF to tokenize and classify a Japanese mailing address.
2. (Pending) A site to allow others to try this parser online.

# Training

Follow the steps to train the parser from scretch:

1. Run `rake db:migrate`
1. Run `rake db:seed` to seed prefecture/district information.
2. Run `rake data:generate` to create fake Address records.
3. Run `rake data:train` to train a model from these addresses.

After these steps, you can see a `result.mod` file in the project root directory.
This is the model file which can be used to parse address.

# Tokenize and Classify

Simply run the following after model has been trained.

```
tokenizer = LulalalaAddressTokenizer.new('result.mod')
tokenizer.parse("東京都西多摩郡秋多町")
# returns {"prefecture"=>"東京都", "gun"=>"西多摩郡", "municipality"=>"秋多町"}
```

# TODO

1. Improve training by changing the `data/pattern.txt` rules.
2. When generating fake Address, generate further details such as house number.
2. Build website to allow user to try address parsing online.

Help is appreciated if you are interested :)
