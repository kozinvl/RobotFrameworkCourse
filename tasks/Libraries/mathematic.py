"""Example Library to using mathematical operations.

<ul>
  <li>Using <i> +, -, /, * </i> to calculate <b>your variables</b>.
</ul>

            <table border="2">
            <tr>
            <th>5 + 5 = 25</th>
            <tr>
            </table>


"""
ROBOT_LIBRARY_DOC_FORMAT = 'HTML'


def add(arg1, arg2):
    """function which adding your variables.
    <table border="2">
            <tr>
            <th>5 + 5 = 25</th>
            <tr>
            </table>
    """
    return float(arg1) + float(arg2)


def subtract(arg1, arg2):
    """function which subtracting your variables.
    <table border="2">
            <tr>
            <th>5 - 5 = 0</th>
            <tr>
            </table>
    """
    return float(arg1) - float(arg2)


def divide(arg1, arg2):
    """function which dividing your variables.
    <table border="2">
            <tr>
            <th>5 / 5 = 1</th>
            <tr>
            </table>
    """
    return float(arg1) / float(arg2)


def multiply(arg1, arg2):
    """function which multiplying your variables.
    <table border="2">
            <tr>
            <th>5 * 5 = 25</th>
            <tr>
            </table>
    """
    return float(arg1) * float(arg2)
