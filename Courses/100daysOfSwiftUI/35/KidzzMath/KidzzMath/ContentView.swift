import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                RainbowBackground()
                MenuView()
            }.ignoresSafeArea()
        }
    }
}

struct MenuView: View {
    @State var selectedQuestions: Int = 5
    @State var maximumRange: Int = 10

    var body: some View {
        VStack {
            Text("Kidzz Math➕")
                .font(.title)
                .padding(.top, 30)

            VStack {
                VStack(alignment: .leading) {
                    Stepper("Range of tasks: \(maximumRange)", value: $maximumRange, in: 1 ... 12)
                        .font(.callout)

                    Text("Number of tasks:")
                        .font(.callout)
                    Picker("Number of questionsL", selection: $selectedQuestions) {
                        ForEach([5, 10, 20], id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                VStack(alignment: .center) {
                    NavigationLink(destination: QuestionsView(tasks: generateTasks())) {
                        Text("Start")
                            .font(.title)
                    }
                }
            }
            .padding(5)
            .background(Color.white)
            .opacity(0.8)
            .cornerRadius(5)
            .padding(5)
        }
    }

    private func generateTasks() -> ([Int], [Int]) {
        return (generateNumbers(), generateNumbers())
    }

    private func generateNumbers() -> [Int] {
        (1 ... selectedQuestions).map { _ in Int.random(in: 1 ... maximumRange) }
    }
}

struct QuestionsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var answers: [Answer] = []
    @State var currentTask = 0
    @State var questions: [Int] = [1, 1, 1, 1]
    @State var showAlert = false
    @State var alertMessage = ""

    let tasks: ([Int], [Int])

    var correctAnswear: Int {
        tasks.0[currentTask] * tasks.1[currentTask]
    }

    var wrongAnswer: Int {
        correctAnswear + Int.random(in: -10 ... 10)
    }

    var body: some View {
        ZStack {
            RainbowBackground()

            VStack {
                Text("Task \(currentTask + 1) from \(tasks.0.count).")
                    .font(.title)
                Text("\(tasks.0[currentTask]) * \(tasks.1[currentTask]) = ")
                    .font(.title)

                ForEach(0 ..< 4) { index in
                    Button(action: {
                        check(answear: index)
                    }, label: {
                        Text("\(questions[index])")
                            .foregroundColor(.black)
                            .frame(width: 250, height: 40)
                            .padding(5)
                            .background(Color.gray)
                            .cornerRadius(20)
                            .padding(5)
                    })
                }
            }
            .padding(5)
            .background(Color.white)
            .opacity(0.8)
            .cornerRadius(5)
            .padding(5)
        }.onAppear(perform: {
            generateAnswers()
        })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Hey"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Next task.")))
            }
            .ignoresSafeArea()
    }

    func generateAnswers() {
        questions = [correctAnswear, wrongAnswer, wrongAnswer, wrongAnswer].shuffled()
    }

    func check(answear: Int) {
        let answer = Answer(question: (tasks.0[currentTask], tasks.1[currentTask]), correctAswered: questions[answear] == correctAnswear)
        answers.append(answer)
        alertMessage = answer.message
        showAlert = true
        if currentTask < tasks.0.count - 1 {
            currentTask += 1
            generateAnswers()
        } else {
            alertMessage = "True: \(answers.filter { $0.correctAswered == true }.count), Wrong: \(answers.filter { $0.correctAswered == false }.count)"
            showAlert = true
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct RainbowBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
            startPoint: .top, endPoint: .bottom
        )
    }
}

struct Answer {
    let question: (Int, Int)
    let correctAswered: Bool

    var correct: Int {
        question.0 * question.1
    }

    var message: String {
        correctAswered ? "True" : "Wrong"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
