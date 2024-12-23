"""
Simple Test for Calc Function
"""

from django.test import SimpleTestCase
from app import calc


class CalcTests(SimpleTestCase):
    """Test for Calc Functions"""
    def test_add_numbers(self):
        """Test that two numbers are added together"""
        self.assertEqual(calc.add(3, 8), 11)
        self.assertEqual(calc.add(-3, 8), 5)
        self.assertEqual(calc.add(-3, -8), -11)
        self.assertEqual(calc.add(300, 800), 1100)

    def test_subtract_numbers(self):
        """Test that values are subtracted and returned"""
        self.assertEqual(calc.subtract(5, 11), -6)
        self.assertEqual(calc.subtract(11, 5), 6)
        self.assertEqual(calc.subtract(-5, 11), -16)
        self.assertEqual(calc.subtract(-11, 5), -16)
