
all:
	./scrape.sh < articles.txt

clean:
	rm /home/pi/Extended/eeoc.gov/headers/*
	rm /home/pi/Extended/eeoc.gov/html/*
