MI() {
	Soundbeep, 587, 75
	Soundbeep, 622, 75
	Soundbeep, 587, 75
	Soundbeep, 622, 75
	Soundbeep, 587, 75
	Soundbeep, 622, 75
	Soundbeep, 587, 75
	Soundbeep, 622, 75
	Soundbeep, 587, 75
	Soundbeep, 587, 75
	Soundbeep, 622, 75
	Soundbeep, 659, 75
	Soundbeep, 699, 75
	Soundbeep, 740, 75
	Soundbeep, 784, 75
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 932, 150
	sleep, 150
	Soundbeep, 523, 150
	sleep, 150
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 699, 150
	sleep, 150
	Soundbeep, 740, 150
	sleep, 150
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 932, 150
	sleep, 150
	Soundbeep, 523, 150
	sleep, 150
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 784, 150
	sleep, 300
	Soundbeep, 699, 150
	sleep, 150
	Soundbeep, 740, 150
	sleep, 150
	Soundbeep, 932, 150
	Soundbeep, 784, 150
	Soundbeep, 587, 1200
	sleep, 75
	Soundbeep, 932, 150
	Soundbeep, 784, 150
	Soundbeep, 554, 1200
	sleep, 75
	Soundbeep, 932, 150
	Soundbeep, 784, 150
	Soundbeep, 523, 1200
	sleep, 150
	Soundbeep, 466, 150
	Soundbeep, 523, 150
	return
}
MI2() {
	SoundBeep, 620, 200
	sleep, 200
	SoundBeep, 620, 200
	SoundBeep, 750, 200
	SoundBeep, 700, 200
	SoundBeep, 620, 200
	SoundBeep, 560, 400
	SoundBeep, 620, 600
	sleep, 200
	SoundBeep, 560, 200
	sleep, 200
	SoundBeep, 560, 200
	SoundBeep, 500, 200
	SoundBeep, 465, 200
	sleep, 200
	SoundBeep, 560, 200
	sleep, 200
	SoundBeep, 500, 200
	sleep, 200
	SoundBeep, 500, 200
	sleep, 200
	SoundBeep, 465, 600
	return
}
Sim() {
	SoundBeep, 500, 600
	SoundBeep, 620, 400
	SoundBeep, 700, 400
	SoundBeep, 850, 200
	SoundBeep, 750, 600
	SoundBeep, 620, 400
	SoundBeep, 500, 400
	SoundBeep, 420, 200
	SoundBeep, 350, 200
	SoundBeep, 350, 200
	SoundBeep, 350, 200
	SoundBeep, 370, 600
	sleep, 600
	SoundBeep, 350, 200
	SoundBeep, 350, 200
	SoundBeep, 350, 200
	SoundBeep, 370, 200
	SoundBeep, 450, 600
	SoundBeep, 500, 200
	SoundBeep, 500, 200
	SoundBeep, 500, 200
	SoundBeep, 500, 400
	return
}
RM() {
	Random, rnd, 1, 3
	switch rnd
	{
		case 1: MI()
		case 2: MI2()
		case 3: Sim()
		default:
	}
}