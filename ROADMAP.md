# Project Roadmap: Patient Consent Form App

## Overview
A Flutter Android application for tablet devices designed for doctors to manage patient consent forms. All data is currently stored locally on the device.

## Features Roadmap

### Phase 1: Core Functionality (Current Focus)
> **Note:** Initially, the entire application will run using **mock data** to simulate patients, forms, and history until the local database is fully implemented.

- [ ] **Landing Page / Dashboard**
    - [ ] **Header**:
        - [ ] Clinic Name (e.g., "Dr. Pravin's Clinic") centered.
        - [ ] Menu/Hamburger icon on the left.
        - [ ] User profile icon on the right.
    - [ ] **Tabs Navigation**:
        - [ ] "Consent Forms" (Active state with blue underline).
        - [ ] "Signed Forms".
    - [ ] **Consent Forms Grid**:
        - [ ] Grid layout (2 columns on tablet) displaying available consent forms.
        - [ ] Cards with specific icons (blue outline style) and titles:
            - [ ] Crown and Bridge Procedures
            - [ ] Dental Implant Procedure
            - [ ] Teeth whitening Treatment
            - [ ] Dental Radiographs
            - [ ] Dental Examination
            - [ ] Local Anaesthesia
            - [ ] Root Canal Treatment
            - [ ] Orthodontic Treatment
            - [ ] Removable Prosthodontics Treatment
            - [ ] Scaling and Root Planing
            - [ ] Tooth Removal / Minor Oral Surgery
    - [ ] **Other Forms Section**:
        - [ ] Separate section for "Other forms" (e.g., Patient Case History).
    - [ ] **Floating Action Button (FAB)**:
        - [ ] "Add" button with pencil icon, bottom right corner.

- [ ] **Patient Management**
    - [ ] Add new patient details.
    - [ ] Find/Search for existing patients.
    - [ ] List all patients.

- [ ] **Consent Forms**
    - [ ] Digital consent form interface.
    - [ ] Capture patient signature.
    - [ ] Save signed forms locally.

- [ ] **View Records**
    - [ ] View signed consent forms for a specific patient.
    - [ ] List history of consent forms.

- [ ] **Data Storage**
    - [ ] Implement local database (e.g., Hive, Drift, or SQFlite) for storing patient data and forms.

### Phase 2: Enhancements (Future)
- [ ] Data synchronization with a backend server.
- [ ] Export forms to PDF.
- [ ] Multi-language support (Hindi, Bengali, Gujarati, etc. as per styling).
- [ ] User authentication for doctors.

## Styling Requirements
- Adhere to the design system defined in `global.json`.
- Support for multiple Indian languages in typography.
