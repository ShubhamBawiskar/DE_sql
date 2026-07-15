-- =================================================================================================================================
-- 1. An agent is trying to register a new client in the system through the agency's internal application. When they submit the form, they get an error saying "Client Name cannot be empty. Which constraint on which table's column is preventing this entry.
-- =================================================================================================================================



-- =================================================================================================================================
--  2. A new insurance product, "Premium Health Plus," is being added to the system. An employee accidentally tries to add another insurance type with the exact same name. The system flags it as an error. Which constraint on the Insurance table's name column would prevent this?
-- =================================================================================================================================



-- =================================================================================================================================
--  3. The agency issues unique policy_number values for every new policy. Two agents, working simultaneously, try to issue policies and, due to a rare system glitch, almost assign the same policy_number to different clients. The system immediately rejects one of the operations. specific constraint on the Policy table's policy_number column is preventing the creation of duplicate policy identifiers.
-- =================================================================================================================================



-- =================================================================================================================================
--  4. The agency's call center receives a call from a client who only provides their "Client ID." The operator needs to quickly pull up all their information (name, policies, etc.). What type of constraint on the Client table's id column ensures that "Client ID" can be reliably used as the sole identifier to instantaneously retrieve a client's complete record without ambiguity, even with millions of clients?
-- =================================================================================================================================



-- =================================================================================================================================
--  5. A junior agent attempts to input a new policy where the end_date is earlier than the start_date by mistake. The system immediately rejects the input and displays an error message: "End Date must be after Start Date." What CHECK constraint is active on the Policy table's date columns to enforce logical consistency of policy periods in real-time data entry?
-- =================================================================================================================================



-- =================================================================================================================================
--  6. Create customer table with below details: 
-- =================================================================================================================================



-- =================================================================================================================================
--  7. Create transaction table with below details.
-- =================================================================================================================================



