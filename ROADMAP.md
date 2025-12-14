# Project Roadmap: Patient Consent Form App

## Overview
A Flutter Android application for tablet devices designed for doctors to manage patient consent forms. All data is currently stored locally on the device.

## Features Roadmap

### Phase 1: Core Functionality (Current Focus)
> **Note:** Initially, the entire application will run using **mock data** to simulate patients, forms, and history until the local database is fully implemented.

- [x] **Landing Page / Dashboard**
    - [x] **Header**:
        - [x] Clinic Name (e.g., "Dr. Pravin's Clinic") centered.
        - [x] Menu/Hamburger icon on the left.
        - [x] User profile icon on the right.
    - [x] **Tabs Navigation**:
        - [x] "Consent Forms" (Active state with blue underline).
        - [x] "Signed Forms".
    - [x] **Consent Forms Grid**:
        - [x] Grid layout (2 columns on tablet) displaying available consent forms.
        - [x] Cards with specific icons (blue outline style) and titles:
            - [x] Crown and Bridge Procedures
            - [x] Dental Implant Procedure
            - [x] Teeth whitening Treatment
            - [x] Dental Radiographs
            - [x] Dental Examination
            - [x] Local Anaesthesia
            - [x] Root Canal Treatment
            - [x] Orthodontic Treatment
            - [x] Removable Prosthodontics Treatment
            - [x] Scaling and Root Planing
            - [x] Tooth Removal / Minor Oral Surgery
    - [x] **Other Forms Section**:
        - [x] Separate section for "Other forms" (e.g., Patient Case History).
    - [x] **Floating Action Button (FAB)**:
        - [x] "Add" button with pencil icon, bottom right corner.

- [x] **Patient Management**
    - [x] Add new patient details.
    - [x] Find/Search for existing patients.
    - [x] List all patients.

- [x] Consent Forms
    - [x] Digital consent form interface.
    - [x] Capture patient signature.
    - [x] Save signed forms locally.

- [x] **View Records**
    - [x] View signed consent forms for a specific patient.
    - [x] List history of consent forms.

- [x] **Clinic Details / Settings**
    - [x] Edit Doctor Information.
    - [x] Edit Clinic Address & Contact.
    - [x] Set/Update Clinic Logo (Image Picker).
    - [x] Set PIN.

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
