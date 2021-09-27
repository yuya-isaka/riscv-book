package riscvtests

import chisel3._

// ChiselTestを利用するために必要なpackage
import org.scalatest._
import chiseltest._

// ２つのトレイトをテストクラスに継承
class RiscvTest extends FlatSpec with ChiselScalatestTester {
	"mycpu" should "work through hex" in {
		test(new Top) { c =>
			// このブロックでテストを記述（変数cはTopクラスのインスタンス
			while (!c.io.exit.peek().litToBoolean) {
				c.clock.step(1)
			}
			c.io.gp.expect(1.U)
		}
	}
}