var sk1 = Enemy(health: 100, attackStrength: 30)

//깊은 복사 -> 객체의 껍데기만 복사해서 새로운 객체 생성
var sk2 = sk1

sk1.takeDamage(amount: 10)
sk1.takeDamage(amount: 10)

sk2.takeDamage(amount: 10)

print(sk1.health) //80
print(sk2.health) //90

//let dragon = Dragon(health: 200, attackStrength: 20)
//dragon.move()
//dragon.attack() 
//dragon.wing = 4
//dragon.flyWing()
//dragon.move()
