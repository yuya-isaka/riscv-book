package sw

import chisel3._

import org.scalatest._
import chiseltest._

class HexTest extends FlatSpec with ChiselScalatestTester {
	"mycpu" should "work through hex" in {
		test(new Top) { c =>

		// クロック信号生成
		while (!c.io.exit.peek().litToBoolean) {
		c.clock.step(1)
		}

		}
	}
}