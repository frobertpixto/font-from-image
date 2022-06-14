# FontFromImage
## Supervised Learning - Learn Font names from text in an image

This is a cleaned up version of experimentations I did in 2018 after my [Deep Learning Specialization](https://www.coursera.org/specializations/deep-learning) with Andrew Ng in 2018.

Having played a lot with fonts and drawing texts on an image for my **[Mix on Pix](https://apps.apple.com/us/app/mix-on-pix-text-on-photos/id633281586)** app, I wanted to see
if it was possible to use Deep Learning to learn what is the font used in an image.  

![example](readme_images/example1.png)

So I created a 3 steps process:
- Generate images that contain a text from a variety of fonts.
- Do Extract-Transform-Load (ETL) preprocesing to have the data ready for Learning.
- Train a model to identify the font in an image.
 
The model does classification and creates a Saliency Map
![Saliency Map](readme_images/notebook1.png)

---
## Directories
- **data**: The Dataset. Composed of:
  - A json file that contains counts per image type.
  - A directory font_data with 1 sub-directory per Font. For each of the 35 fonts, we have:
    -  86 images with 1 character per image.
    -  250 images with 3 characters per image.
- **ImagesGeneration**: MacOS application generated with Xcode. This application will generate images with text. 
- **notebooks**: Jupyter Notebook for:
  - ETL to generate 50 x 50 images and labels. 
  - Performs the actual training to identify the font in the text of an image.

---
by Francois Robert 

