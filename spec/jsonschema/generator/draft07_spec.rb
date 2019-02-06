# frozen_string_literal: true

RSpec.describe Jsonschema::Generator::Draft07 do
  subject(:generator) { described_class.new(json).call }

  let(:json) { {}.to_json }

  describe 'Success' do
    context 'with simple case' do
      let(:json) do
        {
          first: 'first',
          second: 2,
          third: 'third',
        }.to_json
      end

      let(:expected_schema) do
        {
          'title' => 'Root',
          'type' => 'object',
          'properties' => {
            'first' => {
              'type' => 'string',
            },
            'second' => {
              'type' => 'integer',
            },
            'third' => {
              'type' => 'string',
            },
          },
          'required' => %w[first second third],
        }
      end

      it 'generates schema correctly' do
        expect(generator).to match expected_schema
      end
    end

    context 'with nested hash' do
      let(:json) do
        {
          nested1: {
            nested2: {
              nested3: {
                nested4: {
                  nested5: '1',
                },
              },
            },
          },
        }.to_json
      end

      let(:expected_schema) do
        {
          'title' => 'Root',
          'type' => 'object',
          'required' => %w[nested1],
          'properties' => {
            'nested1' => {
              'type' => 'object',
              'properties' => {
                'nested2' => {
                  'type' => 'object',
                  'properties' => {
                    'nested3' => {
                      'type' => 'object',
                      'properties' => {
                        'nested4' => {
                          'type' => 'object',
                          'properties' => {
                            'nested5' => {
                              'type' => 'string',
                            },
                          },
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        }
      end

      it 'generates schema correctly' do
        expect(generator).to match expected_schema
      end
    end

    context 'with complex case' do
      let(:json) do
        {
          _id: '5c4774c4192e39a7585275fd',
          index: 0,
          guid: 'fb233eda-9a74-446f-865d-6901e5da117a',
          isActive: true,
          balance: '$1,524.98',
          picture: 'http://placehold.it/32x32',
          age: 28,
          eyeColor: 'green',
          name: 'Perkins Harvey',
          gender: 'male',
          company: 'KOFFEE',
          email: 'perkinsharvey@koffee.com',
          phone: '+1 (841) 535-2493',
          address: '241 Madison Street, Templeton, Virginia, 1537',
          about: 'Incididunt in consequat est aliquip nulla et. '\
                 'Eu laborum dolore magna et amet sint ad nulla ut '\
                 'eu nostrud. Anim proident non officia ipsum aliqua '\
                 'officia ex deserunt. Anim enim reprehenderit proident '\
                 'consequat. Occaecat id anim nulla ut cupidatat deserunt '\
                 'eu Lorem. Mollit ea nisi amet magna incididunt magna tempor '\
                 "duis in consectetur Lorem.\r\n",
          registered: '2018-07-06T04:30:17 -03:00',
          latitude: 13.765856,
          longitude: -9.772866,
          tags: %w[
            est
            labore
            consectetur
            proident
            officia
            sit
            duis
          ],
          friends: [
            {
              id: 0,
              name: 'Brandy Taylor',
            },
            {
              id: 1,
              name: 'Toni Francis',
            },
            {
              id: 2,
              name: 'Frieda Owen',
            },
          ],
          nested: {
            object: {
              in: {
                other: {
                  object: '1',
                },
              },
            },
          },
          greeting: 'Hello, Perkins Harvey! You have 2 unread messages.',
          favoriteFruit: 'apple',
        }.to_json
      end

      let(:expected_schema) do
        {
          'title' => 'Root',
          'type' => 'object',
          'required' => %w[
            _id
            index
            guid
            isActive
            balance
            picture
            age
            eyeColor
            name
            gender
            company
            email
            phone
            address
            about
            registered
            latitude
            longitude
            tags
            friends
            nested
            greeting
            favoriteFruit
          ],
          'properties' => {
            '_id' => {
              'type' => 'string',
            },
            'index' => {
              'type' => 'integer',
            },
            'guid' => {
              'type' => 'string',
            },
            'isActive' => {
              'type' => 'boolean',
            },
            'balance' => {
              'type' => 'string',
            },
            'picture' => {
              'type' => 'string',
            },
            'age' => {
              'type' => 'integer',
            },
            'eyeColor' => {
              'type' => 'string',
            },
            'friends' => {
              'type' => 'array',
              'items' => {
                'type' => 'object',
                'properties' => {
                  'id' => {
                    'type' => 'integer',
                  },
                  'name' => {
                    'type' => 'string',
                  },
                },
              },
            },
            'name' => {
              'type' => 'string',
            },
            'gender' => {
              'type' => 'string',
            },
            'company' => {
              'type' => 'string',
            },
            'email' => {
              'type' => 'string',
            },
            'phone' => {
              'type' => 'string',
            },
            'address' => {
              'type' => 'string',
            },
            'about' => {
              'type' => 'string',
            },
            'registered' => {
              'type' => 'string',
            },
            'latitude' => {
              'type' => 'number',
            },
            'longitude' => {
              'type' => 'number',
            },
            'tags' => {
              'type' => 'array',
              'items' => {
                'type' => 'string',
              },
            },
            'favoriteFruit' => {
              'type' => 'string',
            },
            'greeting' => {
              'type' => 'string',
            },
            'nested' => {
              'type' => 'object',
              'properties' => {
                'object' => {
                  'type' => 'object',
                  'properties' => {
                    'in' => {
                      'type' => 'object',
                      'properties' => {
                        'other' => {
                          'type' => 'object',
                          'properties' => {
                            'object' => {
                              'type' => 'string',
                            },
                          },
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        }
      end

      it 'generates schema correctly' do
        expect(generator).to match expected_schema
      end
    end
  end

  describe 'Fail' do
    context 'when input is not json' do
      let(:json) { { key: :value } }

      it 'raises error' do
        expect { generator }
          .to raise_error Jsonschema::Generator::Error,
                          'Invalid Input. JSON expected'
      end
    end
  end
end
