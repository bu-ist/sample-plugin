<?php

class TestAwesome extends WP_UnitTestCase {
	function setUp() {  
		parent::setUp();
	}
	function testAddition() {
		$awesome = new AwesomePlugin();

		// Ensure the awesomeness has begun.
		// Should have 1 awesome.
		$this->assertEquals( $awesome->number, 1 );

		// Add 2. Should now have 3 awesomes.
		$awesome->add(2);
		$this->assertEquals( $awesome->number, 3 );
	}
}