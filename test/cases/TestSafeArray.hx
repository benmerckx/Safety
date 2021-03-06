package cases;

import utest.Assert;
import safety.OutOfBoundsException;

class TestSafeArray extends BaseCase {

	public function testRead_outOfBounds_shouldThrow() {
		var a:SafeArray<Int> = [];
		Assert.raises(() -> a[0], OutOfBoundsException);
		Assert.raises(() -> a[-1], OutOfBoundsException);
	}

	public function testWrite_outOfBounds_shouldThrow() {
		var a:SafeArray<Int> = [];
		Assert.raises(() -> a[10] = 2, OutOfBoundsException);
		Assert.raises(() -> a[-1] = 2, OutOfBoundsException);
	}

	public function testWrite_atLength_shouldPass() {
		var a:SafeArray<Int> = [];
		a[a.length] = 5;
		Assert.same([5], a);
	}

	#if !SAFETY_DISABLE_SAFE_ARRAY
	public function testArrayDeclaration_automaticallyConvertedToSafeArray() {
		var a = ["hello", "wtf"];
		//If `a` was automatically typed as `SafeArray` out-of-bounds reading will throw
		Assert.raises(() -> a[10], OutOfBoundsException);
	}

	public function testArrayDeclaration_inSwitchAndCase_shouldNotBeConverted() {
		//this test should pass compilation
		switch([Std.random(2), Std.random(2)]) {
			case [0, 1]: Assert.pass();
			case [1, 0]: Assert.pass();
			case _: Assert.pass();
		}
	}
	#end
}