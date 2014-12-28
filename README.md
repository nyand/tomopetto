Tomopetto （友ペット）
=========
*Check DEVELOP branch for latest additions/changes to the code. MASTER will be empty until a stable release is complete.*

Tomopetto is a pet simulation game similar to Tomodatchi. It is developed with Ruby using the [Gosu](http://www.libgosu.org/) framework.
The goal of this project was to learn to program in Ruby and to learn the basics of programming a 2D game architecture and engine.

Game Architecture and Design Decisions
=========
The game architecture mainly uses `GameObject` to represent the objects in the world. `GameObject` are made of components such as
`PositionComponent` to represent its position in the world, `RectangleComponent` to represent a body for physics and collision
detection. Communications between components are down through a Publisher/Subscriber model, where all components subscribes to
the parent `GameObject` publisher hub. The parent `GameObject` handles pushing `Message` that to the components. The components
read the payload and deal with it however it wants.

The world is managed by managers such as `SceneManager`, `GameObjectManager` ,`PhysicsManager` and so fourth. A `Space` handles
all the managers. A `Space` represents a indepedent world with its own managers, usually representing each level or stage such
as menus, cutscenes and each room. This is wrapped up in a `Scene` which is then managed by a `SceneManager` that handles the
transitions between each `Scene`.

An attempt to balance between engineering the architecture for code quality and simply getting things done was made. This was 
done to avoid analysis paralysis while writing code that could scale, all while learning Ruby and game architecture. Design
patterns such as Observers, Components, FSM, Spartial Partitions were used throughout when deemed appropriate.
