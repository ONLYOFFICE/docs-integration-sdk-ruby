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

Rake::Task.define_task(:test) do
  require "simplecov"

  SimpleCov.command_name("Unit Tests")
  SimpleCov.add_filter(/.*_test\.rb/)
  SimpleCov.enable_coverage(:branch)
  SimpleCov.minimum_coverage(line: 80, branch: 80)
  SimpleCov.minimum_coverage_by_file(line: 80, branch: 80)
  SimpleCov.start

  for f in Dir.glob("lib/**/*_test.rb")
    require_relative f
  end
end

Rake::Task.define_task(:test_fork) do
  require "simplecov"

  SimpleCov.command_name("Unit Tests")
  SimpleCov.add_filter(/.*_test\.rb/)
  SimpleCov.enable_coverage(:branch)
  SimpleCov.minimum_coverage(line: 80, branch: 80)
  SimpleCov.minimum_coverage_by_file(line: 80, branch: 80)
  SimpleCov.start

  c = 0

  for f in Dir.glob("lib/**/*_test.rb")
    pid = fork do
      SimpleCov.at_fork.call(Process.pid)
      require_relative f
    end

    Process.wait(pid)

    if c == 0 && !$?.success?
      c = 1
    end
  end

  exit(c)
end
