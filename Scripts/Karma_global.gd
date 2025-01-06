extends Node

var KARMA_SCORE = 0

func judgement(karma: int):
		if karma <10:
			print_debug("you're an ass")
		elif karma >=10 and karma <20:
			print_debug("you did well")
		elif karma >20:
			print_debug("idiale schoonzoon")
