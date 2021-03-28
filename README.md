# FontFromImage
## Learn Font names from text in an image

This is a clean-up version of experimentations that I did in 2018 after my [Deep Learning Specialization](https://www.coursera.org/specializations/deep-learning) with Andrew Ng in 2018.

Having played a lot with font and drawing text on an image for my **[Mix on Pix](https://apps.apple.com/us/app/mix-on-pix-text-on-photos/id633281586)** app, I wanted to see
if it was possible to use Deep Learning to learn what is the font used in an image.  

So I created a 3 step process:
- Generate images that contain text from a variety of fonts.
- Do Pre-procesing to have the data ready for Learning.
- Train a model to identify the font in an image.

---
## Directories
- **ImagesGeneration**: MacOS application generated with Xcode. This application will generate images with text
- **ImagesProcessing**: Jupyter Notebook for pre-processing to generate 50 x 50 images and labels
- **Training**: Jupyter Notebook that performs the actual training

---
by Francois Robert 

