# precommit-test-integrity
Bash script for testing the integrity of tests by detecting focus cases before commit.

Put simply, it checks `git diff` for "focus" cases such as `fit`, `fdescribe` where your test integrity could be affected quietly without you knowing if they were present -- your tests would pass, but only because you've effectively disabled most of them.
