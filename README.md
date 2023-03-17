# Image Processor

This project provides a simple image processing service that can be used to resize, crop, and apply various filters to images.

## Requirements

Docker

## Usage

### Clone the repository:
git clone https://github.com/<username>/image_processor.git

### Change directory to the project root:
cd image_processor

### Start the services using Docker Compose:
docker-compose up --build

The web service will be available at http://0.0.0.0:9292. 
You can use the following endpoints to process images:
POST /process_image: Processes an image using the specified operations.
Format of the request coming example:
{
“fileUrl”:
“https://previews.123rf.com/images/happyroman/happyroman1611/happyroman16110000
4/67968361-atm-transaction-printed-paper-receipt-bill-vector.jpg”
}
