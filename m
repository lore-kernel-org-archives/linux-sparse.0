From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Bogus sparse warning?
Date: Mon, 12 Feb 2007 10:05:08 +0000
Message-ID: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:38193 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbXBLK1U (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 05:27:20 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Using latest code from git://git.kernel.org/pub/scm/linux/kernel/git/ 
josh/sparse.git

When I run:  make CHECKFLAGS="-D__CHECK_ENDIAN__" C=2 modules

I get this warning:

   CHECK   fs/ntfs/file.c
fs/ntfs/file.c:2241:5: warning: incorrect type in argument 8  
(different signedness)
fs/ntfs/file.c:2241:5:    expected int [signed] ( [signed] [usertype]  
get_block )( ... )
fs/ntfs/file.c:2241:5:    got int [signed] ( static [toplevel]  
*<noident> )( ... )

The relevant code to reproduce this is:

 From <include/linux/fs.h>:

typedef int (get_block_t)(struct inode *inode, sector_t iblock,
                         struct buffer_head *bh_result, int create);

static inline ssize_t blockdev_direct_IO(int rw, struct kiocb *iocb,
         struct inode *inode, struct block_device *bdev, const struct  
iovec *iov,
         loff_t offset, unsigned long nr_segs, get_block_t get_block,
         dio_iodone_t end_io)
{
}

In my current <fs/ntfs/file.c>:

static int ntfs_get_block_for_direct_IO_write(struct inode *vi,  
sector_t blk,
                 struct buffer_head *bh, int create)
{
}

And later (this is line 2240 from the error message):

                 written = blockdev_direct_IO(WRITE, iocb, vi, vi- 
 >i_sb->s_bdev,
                                 iov, pos, *nr_segs,
                                 ntfs_get_block_for_direct_IO_write,  
NULL);

Why is sparse complaining?  And perhaps more importantly how do I  
make the warning go away?

Thanks a lot in advance!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
