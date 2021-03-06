Class {
	#name : #MAPatchMacro,
	#superclass : #Object,
	#instVars : [
		'operations',
		'model'
	],
	#category : #'Magritte-Merging'
}

{ #category : #accessing }
MAPatchMacro >> children [
	^ self operations
]

{ #category : #'accessing-magritte' }
MAPatchMacro >> descriptionOperations [
	<magritteDescription>
	<gtInspectorPresentationOrder: 1>
	^ MAToManyRelationDescription new
		accessor: #operations;
		glmPresentation: [ :a | a list ];
		classes: { MAPatchOperation };
		yourself
]

{ #category : #accessing }
MAPatchMacro >> diffStrings [
	| lhs rhs |
	lhs := String streamContents: [ :lstr |
		rhs := String streamContents: [ :rstr | 
			self operations 
				do: [ :op |
					| opDiff |
					opDiff := op diffStrings.
					lstr nextPutAll: opDiff first.
					rstr nextPutAll: opDiff second ]
				separatedBy: [ lstr lf. rstr lf ] ] ].
	^ { lhs. rhs }
]

{ #category : #execution }
MAPatchMacro >> execute [
	self operations do: #execute
]

{ #category : #execution }
MAPatchMacro >> model [
	^ model
]

{ #category : #accessing }
MAPatchMacro >> model: anObject [
	model := anObject
]

{ #category : #execution }
MAPatchMacro >> operations [
	^ operations
]

{ #category : #accessing }
MAPatchMacro >> operations: anObject [
	operations := anObject
]

{ #category : #printing }
MAPatchMacro >> printOn: aStream [

	model 
		ifNotNil: [ 
			aStream
				nextPutAll: 'Patch for ';
				print: model ]
		ifNil: [ super printOn: aStream ]
]

{ #category : #execution }
MAPatchMacro >> undo [
	self operations do: #undo
]
