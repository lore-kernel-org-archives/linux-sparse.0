From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Sparse just seg faulted on me!
Date: Wed, 14 Feb 2007 09:04:48 +0000
Message-ID: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:42415 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbXBNJF0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 04:05:26 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse <linux-sparse@vger.kernel.org>

I typoed (see CTL_UNNUMBRED should be CTL_UNNUMBERED) and got an  
error which is fine but then sparse seg faulted!  I think that is a  
bug...

$ make CHECKFLAGS="-D__CHECK_ENDIAN__" C=2 modules
[snip]
  CHECK   fs/ntfs/sysctl.c
fs/ntfs/sysctl.c:38:15: error: undefined identifier 'CTL_UNNUMBRED'
/bin/sh: line 1: 26154 Segmentation fault      sparse - 
D__CHECK_ENDIAN__ -Wp,-MD,fs/ntfs/.sysctl.o.d -nostdinc -isystem /usr/ 
lib/gcc/i586-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -include  
include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno- 
trigraphs -fno-strict-aliasing -fno-common -Os -pipe -msoft-float - 
mregparm=3 -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium4 - 
ffreestanding -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 - 
DCONFIG_AS_CFI_SIGNAL_FRAME=1 -Iinclude/asm-i386/mach-default -fno- 
omit-frame-pointer -fno-optimize-sibling-calls -g -fno-stack- 
protector -Wdeclaration-after-statement -Wno-pointer-sign - 
DNTFS_VERSION=\"2.3\" -DDEBUG -DNTFS_RW -DMODULE -D"KBUILD_STR(s)=#s"  
-D"KBUILD_BASENAME=KBUILD_STR(sysctl)" -D"KBUILD_MODNAME=KBUILD_STR 
(ntfs)" fs/ntfs/sysctl.c
make[2]: *** [fs/ntfs/sysctl.o] Error 139
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2

This is the code snippet should allow you to reproduce it:

#include <linux/module.h>
#include <linux/proc_fs.h>
#include <linux/sysctl.h>

extern int debug_msgs;

/* Definition of the ntfs sysctl. */
static ctl_table ntfs_sysctls[] = {
         {
                 .ctl_name = CTL_UNNUMBRED,      /* No binary ID. */
                 .procname = "ntfs-debug",       /* Text ID. */
                 .data = &debug_msgs,            /* Data pointer and  
size. */
                 .maxlen = sizeof(debug_msgs),
                 .mode = 0644,                   /* Mode. */
                 .proc_handler = &proc_dointvec, /* Proc handler. */
         },
         {}
};

Fixing the typo allows it to complete:

   CHECK   fs/ntfs/sysctl.c
   CC [M]  fs/ntfs/sysctl.o

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
