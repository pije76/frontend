from django.db import models

# Create your models here.
class Seed(models.Model):
	seed_file = models.BinaryField()

	def __str__(self):
		return str(self.seed_file)
