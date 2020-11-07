## shared list of tipp3 programs
# note: 44b_sat-nov-2 starts on a saturday!
PROGRAMS_2019 = %w[
  21a_tue-may-21   21b_fri-may-24
  22a_tue-may-28   22b_fri-may-31
  23a_tue-june-4   23b_fri-june-7
  24a_tue-june-11  24b_fri-june-14
  25a_tue-june-18  25b_fri-june-21
  26a_tue-june-25  26b_fri-june-28
  27a_tue-july-2   27b_fri-july-5
  28a_tue-july-9   28b_fri-july-12
  29a_tue-july-16  29b_fri-july-19
  30a_tue-july-23  30b_fri-july-26
  31a_tue-july-30  31b_fri-aug-2
  32a_tue-aug-6    32b_fri-aug-9
  33a_tue-aug-13   33b_fri-aug-16
  34a_tue-aug-20   34b_fri-aug-23
  35a_tue-aug-27   35b_fri-aug-30
  36a_tue-sep-3    36b_fri-sep-6
  37a_tue-sep-10   37b_fri-sep-13
  38a_tue-sep-17   38b_fri-sep-20
  39a_tue-sep-24   39b_fri-sep-27
  40a_tue-oct-1    40b_fri-oct-4
  41a_tue-oct-8    41b_fri-oct-11
  42a_tue-oct-15   42b_fri-oct-18
  43a_tue-oct-22   43b_fri-oct-25
  44a_tue-oct-29   44b_sat-nov-2
  45a_tue-nov-5    45b_fri-nov-8
  46a_tue-nov-12   46b_fri-nov-15
  47a_tue-nov-19   47b_fri-nov-22
  48a_tue-nov-26   48b_fri-nov-29
  49a_tue-dec-3    49b_fri-dec-6
  50a_tue-dec-10   50b_fri-dec-13
  51a_tue-dec-17   51b_fri-dec-20
  52a_mon-dec-23   52b_fri-dec-27
].map { |name| "2019-#{name}" }

PROGRAMS_2020 = %w[
  01a_mon-dec-30   01b_fri-jan-3
  02a_tue-jan-7

  20a_tue-may-12   20b_fri-may-15
  21a_tue-may-19   21b_fri-may-22
  22a_tue-may-26   22b_fri-may-29
  23a_tue-jun-2    23b_fri-jun-5
  24a_tue-jun-9
].map { |name| "2020-#{name}" }


PROGRAMS = PROGRAMS_2019 + PROGRAMS_2020
