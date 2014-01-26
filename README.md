DataEncryptionStandard
======================

Implementation of 64-bits DES algorithm with VHDL. 

Based on http://csrc.nist.gov/publications/fips/fips46-3/fips46-3.pdf 

Author: Jim Stanev

Wiki Greek: https://github.com/mitkof6/DataEncryptionStandard/wiki/Implementation-of-64-bits-Data-Encryption-Standard-using-VHDL

Description
===========

Language: VHDL

* DES_TOP: Top level container
  * IP, IIP: Internal assignment
  * MAIN_LOOP: The loop funcion
    * F: Chiper function
      * E: Expansion
      * P: Permutation
      * S1..S16: Selection function
  * KEY_SCHEDULE: Generates all 16 keys
    * PC1: permuted choice 1
    * PC2: permuted choice 2

