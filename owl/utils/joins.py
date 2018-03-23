from owl.models import Job, Owl


def hash_join():
    jobs = Job.objects.all()
    owls = Owl.objects.all()

    for owl in owls:
        for job in jobs:
            if owl.job_id == job.id:
                owl.job = job
                break

    return owls

def nested_loops():
    jobs = Job.objects.all()
    owls = Owl.objects.all()

    for owl in owls:
        for job in jobs:
            if owl.job_id == job.id:
                owl.job = job
                break

    return owls
