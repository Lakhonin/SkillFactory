function condition(value, index, array) {
    var result = false;
    if (value === 8) {
        result = true;
    }
    return result;
};
function square(value, index, array) {

    var result = value * value;
    document.write("Квадрат нашего числа " + value + " равен " + result + "<br/>");
};

