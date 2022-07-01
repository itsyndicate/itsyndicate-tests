from django.db import models


class UploadedImage(models.Model):
    name = models.CharField('Name of image', max_length=256)
    image = models.ImageField('Image')

    class Meta:
        verbose_name = 'image'
        verbose_name_plural = 'images'
