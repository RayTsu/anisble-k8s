#!/usr/bin/python
# -*- coding:utf-8 -*-
import os

def endWith(s,*endstring):
    array=map(s.endswith,endstring)
    if True in array:
        return True
    else:
        return False

content_dir='/app/sonatype-work/nexus3/blobs/default/content'
vol_files=os.listdir(content_dir)
for dir1 in vol_files:
    if 'vol' in dir1:
        vol_dir=content_dir+'/'+dir1
        chap_files=os.listdir(vol_dir)
        for dir2 in chap_files:
            files=os.listdir(vol_dir+'/'+dir2)
            for file in files:
                if endWith(file,'.properties'):
                    try:
                        prop_files=open(vol_dir+'/'+dir2+'/'+file,'r')
                        data=prop_files.read()
                        if 'deleted=true' in data:
                            os.remove(vol_dir+'/'+dir2+'/'+file)
                            os.remove(vol_dir+'/'+dir2+'/'+file.split('.')[0]+'.bytes')
                    except IOError,e:
                        print "*** file open error:",e
                    finally:
                        prop_files.close()
