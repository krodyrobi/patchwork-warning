<?php


use PHPUnit\Framework\TestCase;
use function Patchwork\redefine;
use function Patchwork\restoreAll;


class SampleTest extends TestCase {
	public function tearDown() {
		parent::tearDown();
		restoreAll();
	}

	public function test_define() {
		redefine( 'define', function () {} );

		define( 'TEST', 1 );

		$this->assertFalse( defined( 'TEST' ) );
		$this->assertTrue( defined( 'SOME_CONSTANT' ) );
	}
}