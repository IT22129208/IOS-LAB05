import Foundation

struct Student: Identifiable {
    let id = UUID()
    var name: String
    var mark: Int
    
    var passed: Bool {
        mark >= 50
    }
    
    // Additional Challenge: Computed Grade Property
    var grade: String {
        switch mark {
        case 80...100:
            return "A"
        case 75..<80:
            return "A-"
        case 70..<75:
            return "B+"
        case 65..<70:
            return "B"
        case 60..<65:
            return "B-"
        case 55..<60:
            return "C+"
        case 45..<55:
            return "C"
        case 40..<45:
            return "C-"
        default:
            return "F"
        }
    }
}
```[cite: 47]

---

### 2. `ContentView.swift` (Main Screen)
Replace the contents of `ContentView.swift` with the following implementation containing state management, input validation (`guard`), a scrolling list, navigation, and dynamically updated passing student counts[cite: 47]:

```swift
import SwiftUI

struct ContentView: View {
    @State private var students: [Student] = [
        Student(name: "Amal", mark: 72),
        Student(name: "Nimali", mark: 45),
        Student(name: "Ruwan", mark: 58)
    ]
    
    @State private var studentName = ""
    @State private var markText = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                // Input Form Section
                VStack(spacing: 10) {
                    TextField("Student Name", text: $studentName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Mark", text: $markText)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    
                    Button("Add Student") {
                        guard !studentName.isEmpty else { return }
                        guard let mark = Int(markText) else { return }
                        guard mark >= 0 && mark <= 100 else { return }
                        
                        let newStudent = Student(name: studentName, mark: mark)
                        students.append(newStudent)
                        
                        studentName = ""
                        markText = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                
                // Passed Students Counter
                Text("Passed Students: \(students.filter { $0.passed }.count)")
                    .font(.headline)
                    .padding(.top, 5)
                
                // Student List with Navigation
                List(students) { student in
                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {
                        HStack {
                            Text(student.name)
                            Spacer()
                            Text("\(student.mark)")
                                .bold()
                                .foregroundStyle(student.passed ? .green : .red)
                        }
                    }
                }
            }
            .navigationTitle("SE4041 Marks")
        }
    }
}

#Preview {
    ContentView()
}
```[cite: 47]

---

### 3. `StudentDetailView.swift` (Detail Screen)
Create a new Swift file named `StudentDetailView.swift` to display individual student records when tapped from the list[cite: 47]:

```swift
import SwiftUI

struct StudentDetailView: View {
    let student: Student
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)
            
            Text(student.name)
                .font(.largeTitle)
                .bold()
            
            Text("Mark: \(student.mark)")
                .font(.title2)
            
            Text("Grade: \(student.grade)")
                .font(.title3)
                .bold()
            
            Text(student.passed ? "PASS" : "FAIL")
                .font(.title)
                .bold()
                .foregroundStyle(student.passed ? .green : .red)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Student Details")
    }
}

#Preview {
    StudentDetailView(student: Student(name: "Amal", mark: 72))
}
```[cite: 47]

---

### Repository Setup & Submission Check
1. Ensure your Xcode project structure matches the layout expected by GitHub Classroom[cite: 47]:
   ```text
   MarksApp/
   ├── MarksApp.xcodeproj/
   └── MarksApp/
       ├── MarksAppApp.swift
       ├── ContentView.swift
       ├── Student.swift
       ├── StudentDetailView.swift
       └── Assets.xcassets/