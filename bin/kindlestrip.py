#!/usr/bin/env python

# This is a python script. You need a Python interpreter to run it.
# For example, ActiveState Python, which exists for windows.
#
# This script strips the penultimate record from a Mobipocket file.
# This is useful because the current KindleGen add a compressed copy
# of the source files used in this record, making the ebook produced
# about twice as big as it needs to be.
#
#
# This is free and unencumbered software released into the public domain.
# 
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
# 
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
# 
# For more information, please refer to <http://unlicense.org/>
#
# Written by Paul Durrant, 2010-2011, paul@durrant.co.uk
#
# Changelog
#  1.00 - Initial version
#  1.10 - Added an option to output the stripped data
#  1.20 - Added check for source files section (thanks Piquan)

__version__ = '1.20'

import sys
import struct
import binascii

class Unbuffered:
	def __init__(self, stream):
		self.stream = stream
	def write(self, data):
		self.stream.write(data)
		self.stream.flush()
	def __getattr__(self, attr):
		return getattr(self.stream, attr)

class StripException(Exception):
	pass

class SectionStripper:
	def loadSection(self, section):
		if (section + 1 == self.num_sections):
			endoff = len(self.data_file)
		else:
			endoff = self.sections[section + 1][0]
		off = self.sections[section][0]
		return self.data_file[off:endoff]

	def patch(self, off, new):
		self.data_file = self.data_file[:off] + new + self.data_file[off+len(new):]

	def strip(self, off, len):
		self.data_file = self.data_file[:off] + self.data_file[off+len:]

	def patchSection(self, section, new, in_off = 0):
		if (section + 1 == self.num_sections):
			endoff = len(self.data_file)
		else:
			endoff = self.sections[section + 1][0]
		off = self.sections[section][0]
		assert off + in_off + len(new) <= endoff
		self.patch(off + in_off, new)

	def __init__(self, datain):

		if datain[0x3C:0x3C+8] != 'BOOKMOBI':
			raise StripException("invalid file format")
		self.num_sections, = struct.unpack('>H', datain[76:78])

		#get starting offsets for penultimate and last section
		self.penoffset, = struct.unpack('>L',datain[78+(self.num_sections-2)*8:78+(self.num_sections-2)*8+4])
		self.lastoffset, = struct.unpack('>L',datain[78+(self.num_sections-1)*8:78+(self.num_sections-1)*8+4])

		#check penultimate section for SRCS as first four charcaters
		if datain[self.penoffset:self.penoffset+4] != 'SRCS':
			raise StripException("File doesn't contain the sources section.")

		#reduce section count by one
		self.num_sections = self.num_sections-1
		#copy start of file with new number of sections
		self.data_file = datain[:76] + struct.pack('>H',self.num_sections)

		# copy first n-2 section data, adjusting the offsets
		for i in xrange(self.num_sections-1):
			self.offset, = struct.unpack('>L', datain[78+i*8:78+i*8+4])
			self.data_file += struct.pack('>L',self.offset-8) + datain[78+i*8+4:78+i*8+8]

		#copy and adjust last section data, skipping penultimate one, but using penultimate offset.
		self.data_file += struct.pack('>L',self.penoffset-8) + datain[78+self.num_sections*8+4:78+self.num_sections*8+8]

		#copy rest of file up to penultimate section
		self.data_file += datain[78+self.num_sections*8+8:self.penoffset]

		#copy last section
		self.data_file += datain[self.lastoffset:]
		
		#store away the penultimate section in case the user wants it output
		self.stripped_data_header = datain[self.penoffset:self.penoffset+16]
		self.stripped_data = datain[self.penoffset+16:self.lastoffset]

		print "done"

	def getResult(self):
		return self.data_file

	def getStrippedData(self):
		return self.stripped_data

	def getHeader(self):
		return self.stripped_data_header

if __name__ == "__main__":
	sys.stdout=Unbuffered(sys.stdout)
	print ('KindleStrip v%(__version__)s. '
	   'Written 2010-2011 by Paul Durrant.' % globals())
	if len(sys.argv)<3 or len(sys.argv)>4:
		print "Strips the penultimate record from Mobipocket ebooks"
		print "For ebooks generated using KindleGen 1.1 that adds the source"
		print "Usage:"
		print "    %s <infile> <outfile> <strippeddatafile>" % sys.argv[0]
		print "<strippeddatafile> is optional."
		sys.exit(1)
	else:
		infile = sys.argv[1]
		outfile = sys.argv[2]
		data_file = file(infile, 'rb').read()
		try:
			strippedFile = SectionStripper(data_file)
			file(outfile, 'wb').write(strippedFile.getResult())
			print "Header Bytes: " + binascii.b2a_hex(strippedFile.getHeader())
			if len(sys.argv)==4:
				file(sys.argv[3], 'wb').write(strippedFile.getStrippedData())
		except StripException, e:
			print "Error: %s" % e
			sys.exit(1)
	sys.exit(0)