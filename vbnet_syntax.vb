' ==============================================================================
' VB.NET EXTENSIVE SYNTAX CHEATSHEET (SDK-Style Console / Object-Oriented Blueprint)
' ==============================================================================
Imports System                    ' Import namespaces for base framework types
Imports System.IO                 ' Used for unmanaged stream example (IDisposable)
Imports System.Threading.Tasks    ' Required for modern Async/Await multitasking

' 1. ENUMS (Strongly-typed named constants)
Public Enum GameState
    Menu
    Playing
    Paused
    GameOver
End Enum

' 2. INTERFACES (Contracts defining behaviors)
Public Interface IDamageable
    Property Health As Integer
    Sub TakeDamage(amount As Integer)
End Interface

' 3. STRUCTURES (Value Types: Stored on the Stack, blazing fast, copy-by-value)
Public Structure Point2D
    Public X As Single
    Public Y As Single

    ' Structure Constructor (Requires parameters in VB.NET)
    Public Sub New(x As Single, y As Single)
        Me.X = x
        Me.Y = y
    End Sub
End Structure

' 4. BASE CLASS (Reference Type: Managed Heap object implementing true OOP)
Public Class GameEntity
    ' Encapsulated Private Fields
    Private _name As String

    ' Auto-Implemented Property with default initialization
    Public Property ID As Integer = 100

    ' Full Property definition with explicit backing field
    Public Property Name As String
        Get
            Return _name
        End Get
        Set(value As String)
            If String.IsNullOrWhiteSpace(value) Then Throw New ArgumentException("Name cannot be blank")
            _name = value
        End Set
    End Property

    ' Constructor (Ran once when object is created with "New")
    Public Sub New(entityName As String)
        Me.Name = entityName
    End Sub

    ' Overridable Sub (Method that does not return a value)
    Public Overridable Sub Update()
        ' Virtual logic to be overridden by child classes
    End Sub
End Class

' 5. INHERITANCE & INTERFACE IMPLEMENTATION
Public Class Player
    Inherits GameEntity
    Implements IDamageable

    ' Implementation backing field
    Private _health As Integer

    ' Implement interface property explicitly
    Public Property Health As Integer Implements IDamageable.Health
        Get
            Return _health
        End Get
        Set(value As Integer)
            _health = Math.Clamp(value, 0, 100)
        End Set
    End Property

    ' Constructor passing arguments up to the Base Class constructor
    Public Sub New(playerName As String, startingHealth As Integer)
        MyBase.New(playerName)
        Me.Health = startingHealth
    End Sub

    ' Overriding base class methods
    Public Overrides Sub Update()
        MyBase.Update() ' Calls parent update logic if needed
    End Sub

    ' Implement interface method explicitly
    Public Sub TakeDamage(amount As Integer) Implements IDamageable.TakeDamage
        Me.Health -= amount
    End Sub
End Class

' 6. MAIN CONTROLLER & LANGUAGE CORE SYNTAX DEMO
Public Module Program

    ' Entry Point of the application
    Public Sub Main()
        ' --- CORE DATA TYPES & ARRAYS ---
        Dim score As Integer = 5000                         ' 32-bit Integer
        Dim pi As Double = 3.14159                          ' 64-bit Floating Point
        Dim isGameOver As Boolean = False                  ' Boolean flag
        Dim greeting As String = "Ready Player One"        ' Managed String
        
        ' Arrays (0-Indexed, size declaration indicates the upper bound index)
        Dim highScores(4) As Integer                       ' Array of 5 elements (0 to 4)
        highScores(0) = 100
        highScores(1) = 250
        
        ' Generic Collections
        Dim inventory As New List(Of String)()
        inventory.Add("Sword")
        inventory.Add("Shield")
        inventory.Add("Potion")

        ' --- STRINGS & LITERALS ---
        Dim name As String = "Hero"
        ' String Interpolation ($) & Multi-line strings (Press Enter directly in code)
        Dim statusReport As String = $"Character Status:
Name: {name}
Current Score: {score}"

        ' --- CONDITIONAL STATEMENTS ---
        If score >= 10000 Then
            Console.WriteLine("Legendary Rank!")
        ElseIf score >= 5000 AndAlso Not isGameOver Then    ' Short-circuit logical AND
            Console.WriteLine("Pro Rank!")
        Else
            Console.WriteLine("Noob Rank!")
        End If

        ' Select Case (VB.NET equivalent to switch)
        Dim currentStage As GameState = GameState.Playing
        Select Case currentStage
            Case GameState.Menu
                Console.WriteLine("Showing Menu")
            Case GameState.Playing, GameState.Paused        ' Multiple match commas
                Console.WriteLine("Game Active")
            Case Else
                Console.WriteLine("Unknown State")
        End Select

        ' --- LOOPS ---
        ' For Loop (Inclusive upper bound)
        For i As Integer = 0 To 2
            Console.WriteLine($"Loop Iteration: {i}")
        Next

        ' For Each Loop (Iterate through collections)
        For Each item As String In inventory
            Console.WriteLine($"Inventory Item: {item}")
        Next

        ' While Loop
        Dim countdown As Integer = 3
        While countdown > 0
            countdown -= 1
        End While

        ' --- TRY/CATCH ERROR HANDLING ---
        Try
            Dim zero As Integer = 0
            Dim crash As Integer = 10 \ zero                ' Backslash (\) is integer division
        Catch ex As DivideByZeroException
            Console.WriteLine($"Handled mathematical anomaly: {ex.Message}")
        Finally
            Console.WriteLine("Cleanup processing executed safely.")
        End Try

        ' --- LINQ (Language Integrated Query) ---
        ' Query syntax to filter list
        Dim filteredItems = From item In inventory
                            Where item.StartsWith("S")
                            Select item

        ' --- USING BLOCK (Automatic resource cleanup via IDisposable) ---
        Using writer As New StreamWriter("log.txt")
            writer.WriteLine("Game event session initialized.")
        End Using ' Writer.Dispose() is safely forced immediately at this line

        ' --- CALLING REUSABLE FUNCTIONS & TARGETS ---
        Dim finalDamage As Integer = CalculateDamage(50, 1.5)
        Console.WriteLine($"Damage Engine Output: {finalDamage}")

        ' Call asynchronous operation
        Task.Run(Async Function() As Task
                     Await PerformNetworkSaveAsync()
                 End Function).Wait()

        Console.ReadLine() ' Pause console execution window
    End Sub

    ' 7. FUNCTIONS, OVERLOADING & OPTIONAL PARAMETERS
    ' Function returning a 32-bit Integer value
    Public Function CalculateDamage(baseDmg As Integer, Optional multiplier As Double = 1.0) As Integer
        Return CInt(baseDmg * multiplier) ' CInt explicitly casts types
    End Function

    ' 8. MODERN ASYNC/AWAIT OPERATIONS
    Public Async Function PerformNetworkSaveAsync() As Task
        Console.WriteLine("Uploading save snapshot to server...")
        Await Task.Delay(1000) ' Non-blocking simulated background network ping
        Console.WriteLine("Cloud backup finalized successfully.")
    End Function

End Module
