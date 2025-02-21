#
# (c) Copyright Ascensio System SIA 2025
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"
require "test/unit"

module Onlyoffice
  module DocsIntegrationSdk
    module Test
      module BasicEnumMarshalling
        extend T::Sig
        extend T::Helpers
        include ::Test::Unit::Assertions
        abstract!

        sig {abstract.returns(T::Array[[T.untyped, T::Enum]])}
        def cases; end

        sig {void}
        def test_serialize_serializes
          for v, c in cases
            assert_equal(v, c.serialize)
          end
        end

        sig {void}
        def test_from_serialized_deserializes
          for v, c in cases
            assert_equal(c, c.class.from_serialized(v))
          end
        end
      end

      module DescriptiveEnumMarshalling
        extend T::Sig
        extend T::Helpers
        include ::Test::Unit::Assertions
        abstract!

        sig {abstract.returns(T::Array[[T.untyped, String, T::Enum]])}
        def cases; end

        sig {void}
        def test_serialize_serializes
          for v, _, c in cases
            assert_equal(v, c.serialize)
          end
        end

        sig {void}
        def test_from_serialized_deserializes
          for v, _, c in cases
            assert_equal(c, c.class.from_serialized(v))
          end
        end

        sig {void}
        def test_description_returns_the_description
          for _, d, c in cases
            m = c.method(:description)
            assert_equal(d, m.call)
          end
        end
      end

      module StructMarshalling
        extend T::Sig
        extend T::Helpers
        include ::Test::Unit::Assertions
        abstract!

        sig {abstract.returns(T::Array[[T.untyped, T::Struct]])}
        def cases; end

        sig {void}
        def test_serialize_serializes
          for v, c in cases
            assert_equal(v, c.serialize)
          end
        end

        sig {void}
        def test_from_hash_deserializes
          for v, c in cases
            m = c.class.method(:from_hash)

            t = T::Private::Methods.signature_for_method(m)
            assert_equal(t.return_type.raw_type, c.class)

            s = m.call(v)
            # todo: assert_equal(c, s)
          end
        end
      end
    end
  end
end
