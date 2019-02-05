//
//  GameScene.swift
//  Apple Game
//
//  Created by Bletty Mathew on 2017-07-13.
//  Copyright © 2017 cs2680. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
	var basket: SKSpriteNode?

	var apples = Array<SKSpriteNode>()
	var nextAppleTime: TimeInterval!

	var score: Int = 0
	var scoreLabel: SKLabelNode?

	override func didMove(to view: SKView)
	{
		let backgroundTexture = SKTexture(image: #imageLiteral(resourceName: "Background"))
		let backgroundNode = SKSpriteNode(texture: backgroundTexture)
		backgroundNode.size = CGSize(width: 750, height: 1334)
		self.addChild(backgroundNode)

		let basketTexture = SKTexture(image: #imageLiteral(resourceName: "Basket"))
		basket = SKSpriteNode(texture: basketTexture)
		basket!.size = CGSize(width: 140, height: 130)
		basket!.position = CGPoint(x: 0, y: -540)
		self.addChild(basket!)

		scoreLabel = SKLabelNode(text: "Score: 0")
		scoreLabel?.fontName = "SanFranciso-Bold"
		scoreLabel?.fontSize = 60
		scoreLabel!.position = CGPoint(x: 200, y: 600)
		self.addChild(scoreLabel!)
	}

	func touchDown(atPoint pos : CGPoint)
	{
		basket?.position = CGPoint(x: pos.x, y: -540)
	}
	
	func touchMoved(toPoint pos : CGPoint)
	{
		basket?.position = CGPoint(x: pos.x, y: -540)
	}
	
	func touchUp(atPoint pos : CGPoint)
	{
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		for t in touches
		{	self.touchDown(atPoint: t.location(in: self))
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		for t in touches
		{	self.touchMoved(toPoint: t.location(in: self))
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		for t in touches
		{	self.touchUp(atPoint: t.location(in: self))
		}
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
	{
		for t in touches
		{	self.touchUp(atPoint: t.location(in: self))
		}
	}
	
	override func update(_ currentTime: TimeInterval)
	{
		if nextAppleTime == nil
		{	nextAppleTime = currentTime
		}

		if nextAppleTime! <= currentTime
		{
			self.addApple()
			nextAppleTime = currentTime + 3
		}

		for apple in apples
		{
			if apple.position.y < -510 && apple.position.y > -550
			{	if abs(apple.position.x - basket!.position.x) < 40
				{
					score = score + 1
					scoreLabel?.text = "Score \(score)"

					apple.removeFromParent()

					if let index = apples.index(of: apple)
					{	apples.remove(at: index)
					}
				}
			}
		}
	}

	func addApple()
	{
		let appleX = Int(arc4random_uniform(600)) - 300 // Between (-300 and 300)

		let appleTexture = SKTexture(image: #imageLiteral(resourceName: "Apple"))
		let apple = SKSpriteNode(texture: appleTexture)
		apple.size = CGSize(width: 140, height: 130)
		apple.position = CGPoint(x: appleX, y: 540)
		self.addChild(apple)

		let fallAction = SKAction.moveTo(y: -700, duration: 4)
		apple.run(fallAction)

		self.apples.append(apple)
	}
}
