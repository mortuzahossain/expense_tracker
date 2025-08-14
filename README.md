# Expense Tracker App – Requirements & Plan

## 1. Core Requirements

### 1.1 Features
- **Security**
  - App-level **PIN lock** (4/6 digit) stored securely
  - **Biometric unlock** (fingerprint/Face ID) via `local_auth`
- **Accounts**
  - Add multiple accounts (Cash, Bank, Wallet, etc.)
  - Account type: **Income**, **Expense**, **Transfer**
  - Track account balances
- **Categories**
  - Create categories (with name, type, and icon)
  - Separate categories for Income & Expense
- **Transactions**
  - Add, edit, delete
  - Fields: amount, date, account, category, type, note
  - **Transfer transactions** automatically update both accounts
- **Budgeting**
  - Set monthly/weekly budget per category
  - Show remaining budget progress
- **Reports**
  - Date-to-date filter
  - Category-wise log of expenses/income
  - Income vs Expense chart
  - Account-wise summary
- **Settings**
  - Change PIN
  - Export/Import data (CSV/JSON)
  - Theme switching (Light/Dark)

---

## 2. Technical Plan

### 2.1 Technology Stack
- **Local DB**: `floor` (Room-like ORM for Flutter)
- **State Management**: `riverpod` (simple, reactive, scalable)
- **Secure Storage**: `flutter_secure_storage`
- **Biometric Auth**: `local_auth`
- **Charts**: `fl_chart`
- **Icons**: `flutter_svg`, `material_design_icons_flutter`

---

### 2.2 Database Schema (Floor Entities)
1. **AccountEntity**
   - id
   - name
   - type (`income`/`expense`/`transfer`)
   - balance
   - createdAt
2. **CategoryEntity**
   - id
   - name
   - icon
   - type (`income`/`expense`)
   - createdAt
3. **TransactionEntity**
   - id
   - accountId
   - categoryId
   - amount
   - date
   - type
   - note
   - createdAt
4. **BudgetEntity**
   - id
   - categoryId
   - limitAmount
   - startDate
   - endDate
5. **SettingEntity**
   - key
   - value (for PIN, theme, currency, etc.)

---

### 2.3 App Screens
1. **Splash Screen**
   - Checks if PIN exists → goes to PIN Lock
2. **PIN Lock Screen**
   - Numeric keypad + biometric unlock
3. **Dashboard**
   - Total income/expense this month
   - Quick add transaction
4. **Transactions List**
   - Date range filter, category filter, account filter
5. **Add Transaction**
   - Select account, category, amount, date, note
6. **Accounts**
   - List accounts with balances
7. **Categories**
   - Manage categories with icons
8. **Budget**
   - Set/view budget progress
9. **Reports**
   - Pie chart by category
   - Bar chart monthly trend
10. **Settings**
    - Change PIN, theme, export/import

---

### 2.4 App Flow
1. **First Launch**
   - Ask to set PIN
   - Create default accounts & categories
2. **Daily**
   - Unlock with PIN/biometric
   - Add/view/edit transactions
   - Check budget progress
3. **Reports**
   - Filter by date range
   - Category-wise breakdown

---

### 2.5 Riverpod Usage
- **Providers**:
  - `AccountProvider` (list, add, update balances)
  - `CategoryProvider` (list, add, update)
  - `TransactionProvider` (list, filter by date/category/account)
  - `BudgetProvider` (track budget progress)
  - `SettingsProvider` (PIN, theme, currency)

