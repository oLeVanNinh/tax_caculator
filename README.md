### Assumption
- All income that have is salary, not include allowances and bonuses and OT salary

### To usage
In IRB:
```ruby
# Assume the shell in point to repo folder in local machine
path = `pwd`.chomp
load "#{path}/tax_caculator/lib/tax_caculator.rb"
TaxCaculator.new.run
```
OR with excute permission:
```bash
bin/tax_caculator
```
To run spec:

```ruby
rspec
```
