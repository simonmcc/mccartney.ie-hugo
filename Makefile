# Website hostname, used to set:
# - image and container names
# - path to web root (in /tmp directory)
WEBSITE=mccartney.ie

# S3 bucket name
S3_BUCKET=$(WEBSITE)

# Look up CloudFront distribution ID based on website alias
DISTRIBUTION_ID=$(shell aws cloudfront list-distributions \
	--query 'DistributionList.Items[].{id:Id,a:Aliases.Items}[?contains(a,`$(WEBSITE)`)].id' \
	--output text)

# Look up latest release of Hugo (we might be able to replace this with klakegg/hugo:latest)
# https://github.com/gohugoio/hugo/releases/latest will automatically redirect
# Get Location header, and extract the version number at the end of the URL
HUGO_VERSION=$(shell curl -Is https://github.com/gohugoio/hugo/releases/latest \
	| grep -i -e ^Location \
	| sed -E 's/.*tag\/v(.*)/\1/g;')

default: serve

build: themes
	docker build -t $(WEBSITE) . \
		--build-arg HUGO=$(HUGO_VERSION) \
		--build-arg WEB_DIR=/tmp/$(WEBSITE)

# themes are pulled in via git submodules
themes:
	git submodule update --init

serve: build
	@# Look up IDs of any running containers and dispose of them
	@# Prepend command with a dash to ignore errors (for example, when container doesn't exist)
	-docker ps --filter="name=$(WEBSITE)" -aq | xargs -n1 docker rm -f
	@# --bind 0.0.0.0 <- you have to set this because the default (127.0.0.1)
	@# won't work and you will cry
	docker run \
		--volume ${PWD}:/tmp/$(WEBSITE) \
		--publish 1313:1313 \
		--name $(WEBSITE) \
		$(WEBSITE) \
		hugo server --bind 0.0.0.0

edit:
	@# Open website in the default browser
	open http://localhost:1313
	@# Open local directory in VS Code
	code-insiders .

publish: build
	@# Delete .DS_Store files, they are the bane of existence
	find . -name "*.DS_Store" -type f -delete
	@# Remove existing public/ directory
	rm -rf public/
	@# Build site
	docker run --rm -it --volume `pwd`:/tmp/$(WEBSITE) $(WEBSITE) hugo
	@# Upload files to S3
	aws s3 sync --acl "public-read" --sse "AES256" public/ s3://$(S3_BUCKET) --exclude 'post'
	@# Invalidate caches
	aws cloudfront create-invalidation --distribution-id $(DISTRIBUTION_ID) --paths '/*'

clean:
	@# Stop and remove container
	docker stop $(WEBSITE)
	docker rm $(WEBSITE)

clean-all:
	@# Remove stopped containers
	docker ps -aq -f status=exited --no-trunc | xargs docker rm

	@# Remove dangling/untagged images
	docker images -q -f dangling=true --no-trunc | xargs docker rmi

.PHONY: build serve edit publish clean clean-all
