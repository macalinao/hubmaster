module Github
  class Cipher
    def initialize
      normal = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + [' ']
      shuffled = ["K", "D", "w", "X", "H", "3", "e", "1", "S", "B", "g", "a", "y", "v", "I", "6", "u", "W", "C", "0", "9", "b", "z", "T", "A", "q", "U", "4", "O", "o", "E", "N", "r", "n", "m", "d", "k", "x", "P", "t", "R", "s", "J", "L", "f", "h", "Z", "j", "Y", "5", "7", "l", "p", "c", "2", "8", "M", "V", "G", "i", " ", "Q", "F"]
      
      @map = normal.zip(shuffled).inject(:encrypt => {} , :decrypt => {}) do |hash,(a,b)|
        hash[:encrypt][a] = b
        hash[:decrypt][b] = a
        hash
      end
    end

    def encrypt(data)
      data.split(//).map { |char| @map[:encrypt][char] }.join
    end

    def decrypt(eData)
      eData.split(//).map { |char| @map[:decrypt][char] }.join
    end
  end
end
