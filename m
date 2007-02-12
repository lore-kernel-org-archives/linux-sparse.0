From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Another sparse warning...
Date: Mon, 12 Feb 2007 10:23:38 +0000
Message-ID: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:37015 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964816AbXBLKZg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 05:25:36 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Again, using latest code from git://git.kernel.org/pub/scm/linux/ 
kernel/git/josh/sparse.git

When I run:  make CHECKFLAGS="-D__CHECK_ENDIAN__" C=2 modules

I get this warning:

   CHECK   fs/ntfs/super.c
fs/ntfs/super.c:3003:2: warning: context imbalance in  
'ntfs_fill_super' - unexpected unlock

And ntfs_fill_super does on entry:

unlock_kernel();

And then does "lock_kernel();" on exit.

Which is what causes the warning as the warning goes away if I remove  
it...

The unlock+lock was added by Ingo Molnar IIRC because ntfs_fill_super 
() was causing a huge latency which is bad for RT code...

It is a perfectly legitimate thing to do as the kernel lock is held  
by the VFS but NTFS does not need it as it locks everything  
appropriately internally.

What can I do to tell sparse that this code is ok and there should  
not be a warning?  Is there a "__ignore_context_imbalance" or  
something that I can mark up the {un,}lock_kernel() with or something  
like that?

Thanks a lot in advance!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
