# SQL Sample Data Population with Simplified IDs

1. **User IDs**: Changed to simple 3-digit numbers (100-303)
2. **Property IDs**: Changed to 5-character alphanumeric codes (A1000-C3001)
3. **Booking IDs**: Changed to 5-character codes starting with "BK" (BK100-BK400)
4. **Payment IDs**: Changed to 5-character codes starting with "PA" (PA100-PA400)
5. **Review IDs**: Changed to 5-character codes starting with "RV" (RV100-RV400)

This simplified ID system maintains all relationships while being easier to read and reference. The IDs follow these patterns:
- Users: 3-digit numbers (100 = admin, 200-202 = hosts, 300-303 = guests)
- Properties: Letter + 4 digits (A = Sarah, B = Michael, C = Emma)
- Bookings: BK + 3 digits
- Payments: PA + 3 digits
- Reviews: RV + 3 digits

All relationships between tables are preserved with these simplified IDs.