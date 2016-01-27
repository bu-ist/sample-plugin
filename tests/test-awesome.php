<?php

require dirname( __DIR__ ) . '/functions.php';

class TestAwesome extends WP_UnitTestCase {
	// function setUp() {
	// 	parent::setUp();
	// }
	function testSample() {
		$result = theme_add_things( 4, 6 );
		$this->assertEquals( $result, 10 );
	}
}

