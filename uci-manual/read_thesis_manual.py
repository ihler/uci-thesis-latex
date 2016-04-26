#!/usr/bin/env python2
"""
Downloads and extracts a text version of the UCI thesis manual.
"""
import urllib2
import HTMLParser
import textwrap
import re

#-- read HTML file and convert to plain text
#-- html <div> to read set by flag
def get_contents(url,flag):
	#-- convert HTML symbols to unicode
	hp = HTMLParser.HTMLParser()
	#-- read HTML
	html = urllib2.urlopen(url).read()
	#-- get portions of HTML and remove line breaks
	site_contents = re.findall('%s">(.*?)\<\/div\>' % flag,html.replace('\n','')).pop()
	#-- find and replace style elements
	for s in ['strong','i','b']:
		site_contents = site_contents.replace('<%s>' % s,'').replace('</%s>' % s,'')
	#-- find and replace spans
	regex_pattern = '\<span(.*?)\>(.*?)\<\/span\>'
	spans = re.findall(regex_pattern,site_contents)
	for val in spans:
		from_string = '<span%s>%s</span>' % (val[0],val[1])
		site_contents = site_contents.replace(from_string,val[1])
	#-- find and replace HTML hyperlinks with plain text
	links = re.findall('\<a href\="http(.*?)"(.*?)\>(.*?)\<\/a\>',site_contents)
	for val in links:
		from_string = '<a href="http%s"%s>%s</a>' % (val[0],val[1],val[2])
		if val[2]:
			#-- if not a hidden link: have link in parentheses
			to_string = '%s (http%s)' % (val[2],val[0])
		else:
			#-- if a hidden link: remove
			to_string = ''
		#-- replace html link with text link in parentheses or nothing
		site_contents = site_contents.replace(from_string,to_string)
	#-- extract text from within HTML <> and remove bracketed links
	manual_contents = [hp.unescape(i) for i in re.findall('\>(.*?)\<',site_contents) 
		if i and not bool(re.match('\[(.*?)\]',i))]
	return manual_contents	

def main():
	#-- read table of contents
	url = 'http://special.lib.uci.edu/dissertations/electronic/tdmanuale.html'
	manual_contents = get_contents(url,'sca2Column')
	#-- print thesis table of contents to file
	fid = open('thesis_manual_toc.txt','w')
	for line in manual_contents:
		print >> fid, '\n'.join(textwrap.wrap(line.encode('utf-8'),80))
	fid.close()
	#-- read filing deadlines
	url = 'http://www.grad.uci.edu/academics/filing%20deadlines/index.html'
	manual_contents = get_contents(url,'page-copy')
	#-- print thesis filing deadlines to file
	fid = open('thesis_filing_deadlines.txt','w')
	for line in manual_contents:
		print >> fid, '\n'.join(textwrap.wrap(line.encode('utf-8'),80))
	fid.close()
	#-- read each section
	for section in range(1,8):
		url = 'http://special.lib.uci.edu/dissertations/electronic/td%de.html' \
			% section
		manual_contents = get_contents(url,'sca2Column')
		#-- print thesis section to file
		fid = open('thesis_manual_section_%i.txt' % section,'w')
		for line in manual_contents:
			print >> fid, '\n'.join(textwrap.wrap(line.encode('utf-8'),80))
		fid.close()

#-- run main program
if __name__ == '__main__':
	main()
