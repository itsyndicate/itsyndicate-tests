from django.shortcuts import render
from django.views.generic import ListView
from .models import UploadedImage


class Index(ListView):
    template_name = 'app/index.html'
    paginate_by = 10
    model = UploadedImage
    context_object_name = 'uploaded_images'
