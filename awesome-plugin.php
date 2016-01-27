<?php
/*
Plugin Name: Awesome-plugin
Version: 0.1
Description: Awesomeness included. Free of charge!
Author: Andrew Bauer
Author URI: http://www.bu.edu/tech
*/

class AwesomePlugin {
	
	public $number = 0;

	public function __construct() {
		$this->add(1);
	}

	public function add($n=1){
		$this->number += $n;
		return $this->number;
	}
}
$awesome = new AwesomePlugin();
