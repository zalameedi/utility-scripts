import binascii

n = 10539750919
e = 49
d = 3226366849 
 
plain_text = 5483262135
 

if plain_text > n:
  raise Exception('plain text too large for key')
 
decrypted_text = pow(plain_text, d, n)
print('decrypted text integer  ', decrypted_text)
 
 