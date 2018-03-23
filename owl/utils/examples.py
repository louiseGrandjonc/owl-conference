from owl.models import Letters

def suspicious_letters():
    letters_from_voldemort = Letters.objects.filter(sender_id=3267).select_related('receiver').order_by('sent_at')
    letters_to_voldemort = Letters.objects.filter(receiver_id=3267).order_by('sent_at')
    data = []
    for letter in letters_from_voldemort:
        for answer in letters_to_voldemort:
            if letter.receiver_id == answer.sender_id and letter.sent_at < answer.sent_at:
                data.append([letter.receiver.first_name, letter.receiver.last_name, letter.receiver.id, letter.id, letter.sent_at, answer.id, answer.sent_at])
                break
        else:
            data.append([letter.receiver.first_name, letter.receiver.last_name, letter.receiver.id, letter.id, letter.sent_at])

    return data
