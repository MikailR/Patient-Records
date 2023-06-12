//
//  ContentView.swift
//  Patient Records
//
//  Created by Mikail Rahman on 2023-06-11.
//
import SwiftUI

struct SignupFormView: View {
    @State private var name: String = ""
    @State private var selectedGender: String = ""
    @State private var job: String = ""
    @State private var birthDate: Date = Date()
    @State private var showingQuestionsForm: Bool = false
    
    var body: some View {
            VStack {
                Text("Enter Patient's name:")
                    .font(.headline)
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                Text("Enter Patient's sex:")
                    .font(.headline)
                
                Toggle(isOn: Binding(
                    get: { self.selectedGender == "Male" },
                    set: { newValue in
                        if newValue {
                            self.selectedGender = "Male"
                        }
                    }
                )) {
                    Text("Male")
                }

                Toggle(isOn: Binding(
                    get: { self.selectedGender == "Female" },
                    set: { newValue in
                        if newValue {
                            self.selectedGender = "Female"
                        }
                    }
                )) {
                    Text("Female")
                }
        
                Text("Enter Patient's name:")
                    .font(.headline)
                
                TextField("Occupation", text: $job)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                
                Button(action: {
                    // Perform signup logic
                    performSignup()
                    
                    // Show the questions form
                    showingQuestionsForm = true
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Signup")
            .sheet(isPresented: $showingQuestionsForm) {
                QuestionsFormView()
            }
    }
    
    private func performSignup() {
        // Access the user input values
//        let enteredName = name
//        let enteredBirthDate = birthDate
//
        // Perform signup process
        // ...
    }
}



struct QuestionsFormView: View {
    @State private var selectedConditions: [String] = []
    @State private var durationOfLoss: String = ""
    @State private var isLossOfVisionSelected: Bool = false
    @State private var isSegmentedLossSelected: Bool = false
    @State private var showingPastMedicalHistory: Bool = false
    
    let conditions = [
        "Redness", "Pain", "Epiphora", "Stickiness", "Photophobia",
        "Flashing lights", "Floaters", "Headache",
        "Loss of Vision",
        "Segmented loss",
        "Other"
    ]
    
    let VisionConditionSpeed = [
    "gradual", "sudden"
    ]
    @State private var selectedSpeed = "gradual"
    
    let VisionConditionProgress = [
    "improved", "worsened", "remained the same"
    ]
    @State private var selectedProgress = "improved"
    
    let SegmentedLoss = [
    "sup-nas", "inf-nas", "sup-temp", "inf-temp", "central"
    ]
    @State private var selectedSegmentedLoss = "sup-nas"
    
    var body: some View {
        VStack {
            Text("Which conditions have you experienced?")
                .font(.headline)
                .padding()
            
            List(conditions, id: \.self) { condition in
                if condition == "Loss of Vision" {
                    VStack {
                        MultipleSelectionRow(title: condition, isSelected: self.isSelected(condition: condition)) {
                            if self.isSelected(condition: condition) {
                                self.selectedConditions.removeAll(where: { $0 == condition })
                                self.isLossOfVisionSelected = false
                            } else {
                                self.selectedConditions.append(condition)
                                self.isLossOfVisionSelected = true
                            }
                        }
                        if self.isLossOfVisionSelected {
                            TextField("Duration", text: self.$durationOfLoss)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Text("How fast is your lost of vision:")
                                .font(.headline)
                            
                            Picker(selection: $selectedSpeed, label: Text("")) {
                                ForEach(VisionConditionSpeed, id: \.self) { VisionConditionSpeed in
                                    Text(VisionConditionSpeed)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                                .padding()
                            
                            Text("How has your vision progressed:")
                                .font(.headline)
                            
                            Picker(selection: $selectedProgress, label: Text("")) {
                                ForEach(VisionConditionProgress, id: \.self) { VisionConditionProgress in
                                    Text(VisionConditionProgress)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                                .padding()
                        }
                    }
                }else if condition == "Segmented loss" {
                    VStack {
                        MultipleSelectionRow(title: condition, isSelected: self.isSelected(condition: condition)) {
                            if self.isSelected(condition: condition) {
                                self.selectedConditions.removeAll(where: { $0 == condition })
                                self.isSegmentedLossSelected = false
                            } else {
                                self.selectedConditions.append(condition)
                                self.isSegmentedLossSelected = true
                            }
                        }
                        if self.isSegmentedLossSelected {

                            Picker(selection: $selectedSegmentedLoss, label: Text("")) {
                                ForEach(SegmentedLoss, id: \.self) { SegmentedLoss in
                                    Text(SegmentedLoss)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                                .padding()
                        }
                    }
                }else {
                    MultipleSelectionRow(title: condition, isSelected: self.isSelected(condition: condition)) {
                        if self.isSelected(condition: condition) {
                            self.selectedConditions.removeAll(where: { $0 == condition })
                        } else {
                            self.selectedConditions.append(condition)
                        }
                    }
                }
            }
            .padding()
            
            Button(action: {
                // Perform additional form logic
                performFormSubmission()
                
                showingPastMedicalHistory = true
            }) {
                Text("Medical History")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    }
                    .padding()
            Spacer()
        }
        .padding()
        .navigationTitle("Past Medical History")
        .sheet(isPresented: $showingPastMedicalHistory) {
            PastMedicalHistory()
        }
    }

    private func isSelected(condition: String) -> Bool {
        return selectedConditions.contains(condition)
    }

    private func performFormSubmission() {
        // Access the selected conditions and duration of loss
//        let enteredConditions = selectedConditions
//        let enteredDurationOfLoss = durationOfLoss
        
        // Perform form submission process
        // ...
    }
}
    

struct MultipleSelectionRow: View {
var title: String
var isSelected: Bool
var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                if self.isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
    
    
    
    
struct PastMedicalHistory: View {
    @State private var selectedConditions: [String] = []
    @State private var LastHbA1c: String = ""
    @State private var FBS: String = ""
    @State private var LastBP: String = ""
    @State private var Complications: String = ""
    @State private var isDiabetesSelected: Bool = false
    
    let MedicalConditions = [
        "Diabetes", "Hypertension", "Hyperlipidaemia", "Previous MI", "Previous Stroke",
        "SS/SC/Thalassaemia", "CTD", "Other"
    ]
    
    var body: some View {
        VStack {
            Text("Hello")
                .font(.headline)
                .padding()
            
            List(MedicalConditions, id: \.self) { MedicalCondition in
                if MedicalCondition == "Diabetes" {
                    VStack {
                        MultipleSelectionRow(title: MedicalCondition, isSelected: self.isSelected(MedicalCondition: MedicalCondition)) {
                            if self.isSelected(MedicalCondition: MedicalCondition) {
                                self.selectedConditions.removeAll(where: { $0 == MedicalCondition })
                                self.isDiabetesSelected = false
                            } else {
                                self.selectedConditions.append(MedicalCondition)
                                self.isDiabetesSelected = true
                            }
                        }
                        if self.isDiabetesSelected {
                            TextField("Last HbA1c", text: self.$LastHbA1c)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            TextField("FBS: ", text: self.$FBS)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }
                } else if MedicalCondition == "Hypertension" {
                    VStack {
                        MultipleSelectionRow(title: MedicalCondition, isSelected: self.isSelected(MedicalCondition: MedicalCondition)) {
                            if self.isSelected(MedicalCondition: MedicalCondition) {
                                self.selectedConditions.removeAll(where: { $0 == MedicalCondition })
                                self.isDiabetesSelected = false
                            } else {
                                self.selectedConditions.append(MedicalCondition)
                                self.isDiabetesSelected = true
                            }
                        }
                        if self.isDiabetesSelected {
                            TextField("Last BP/mmHg", text: self.$LastBP)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            TextField("Complications:", text: self.$Complications)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                        }
                    }
                } else {
                    MultipleSelectionRow(title: MedicalCondition, isSelected: self.isSelected(MedicalCondition: MedicalCondition)) {
                        if self.isSelected(MedicalCondition: MedicalCondition) {
                            self.selectedConditions.removeAll(where: { $0 == MedicalCondition })
                        } else {
                            self.selectedConditions.append(MedicalCondition)
                        }
                    }
                }
            }
            .padding()
        }
    }
    private func isSelected(MedicalCondition: String) -> Bool {
        return selectedConditions.contains(MedicalConditions)
    }
}

struct ContentView: View {
var body: some View {
SignupFormView()
}
}

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
ContentView()
}
}

