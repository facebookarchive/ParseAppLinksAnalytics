#!/bin/sh
#
# Copyright (c) 2014, Parse, LLC. All rights reserved.
#
# You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
# copy, modify, and distribute this software in source code or binary form for use
# in connection with the web services and APIs provided by Parse.
#
# As with any software that integrates with the Parse platform, your use of
# this software is subject to the Parse Terms of Service
# [https://www.parse.com/about/terms]. This copyright notice shall be
# included in all copies or substantial portions of the software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# This script builds ParseAppLinksAnalytics.framework

XCODEBUILD='xcodebuild'

FRAMEWORK_NAME='ParseAppLinksAnalytics.framework'
CONFIGURATION_NAME='Release'
TARGET_NAME='ParseAppLinksAnalytics-iOS'
PROJECT_NAME='ParseAppLinksAnalytics.xcodeproj'

echo 'Building framework...'

# Go one level up, to the folder, where the project is located
cd ../

OUTPUT_PRODUCT_DIR='build/'
BUILT_PRODUCT_DIR="$OUTPUT_PRODUCT_DIR/$CONFIGURATION_NAME-iphone/$FRAMEWORK_NAME"
FINAL_FRAMEWORK_PATH="$OUTPUT_PRODUCT_DIR/$FRAMEWORK_NAME"

rm -rf ${OUTPUT_PRODUCT_DIR}

$XCODEBUILD -configuration $CONFIGURATION_NAME -target "$TARGET_NAME" -project "$PROJECT_NAME" || echo 'Build failed' && exit 1

cp -r $BUILT_PRODUCT_DIR $FINAL_FRAMEWORK_PATH
