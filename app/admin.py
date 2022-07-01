from django.contrib import admin
from django.utils.safestring import mark_safe

from .models import UploadedImage


@admin.register(UploadedImage)
class UploadedImageAdmin(admin.ModelAdmin):
    list_display = 'poster', 'name', 'image'

    def poster(self, obj):
        return mark_safe('<a href="' + str(obj.pk) + '/"><img width=50 src="' + obj.image.url + '"/></a>')
