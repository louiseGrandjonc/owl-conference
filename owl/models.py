from __future__ import unicode_literals

from django.db import models


class Job(models.Model):
    name = models.CharField(max_length=255)

    class Meta:
        db_table = 'job'


class Owl(models.Model):
    FUR_CHOICES = (
    (0, 'White'),
    (1, 'Brown'),
    (2, 'Multicoloured'),
    (3, 'Hazelnut'),
)
    name = models.CharField(max_length=255, blank=True, null=True)
    employer_name = models.CharField(max_length=255, blank=True, null=True)
    favourite_food = models.CharField(max_length=255, blank=True, null=True)
    job = models.ForeignKey(Job, null=True, related_name='employees', on_delete=models.SET_NULL)
    fur_color = models.IntegerField(blank=True, null=True, verbose_name='Quality score',
                                    choices=FUR_CHOICES)


    class Meta:
        db_table = 'owl'


class Human(models.Model):
    first_name = models.CharField(max_length=255, blank=True, null=True)
    last_name = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        db_table = 'human'


class Letters(models.Model):
    sender = models.ForeignKey(Human, null=False, related_name='sent_letters', on_delete=models.SET_NULL)
    receiver = models.ForeignKey(Human, null=False, related_name='received_letters', on_delete=models.SET_NULL)
    delivered_by = models.ForeignKey(Owl, null=False, related_name='letters', on_delete=models.SET_NULL, db_column='delivered_by')
    sent_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        db_table = 'letters'
