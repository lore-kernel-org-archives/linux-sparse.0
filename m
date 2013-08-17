From: Theodore Ts'o <tytso@thunk.org>
Subject: What does this sparse warning mean in posix_acl.h?
Date: Sat, 17 Aug 2013 10:28:22 -0400
Message-ID: <nsxtxio1jeh.fsf@lambda.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:45012 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab3HQO2Z (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 17 Aug 2013 10:28:25 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-sparse@vger.kernel.org


It apparently has something to do with rcu and "address spaces" but I'm
not completely sure what sparse is complaining about --- and whether it
is a false positive or a bug in the posix_acl.h.

Can someone explain what's going on, and whether it's something to be
concerned about?

Thanks,

                                                        - Ted

% ../make-ext4 C=1 fs/ext4/acl.o
make[2]: Nothing to be done for `all'.
  GEN     /u1/ext4/Makefile
  CHK     include/generated/uapi/linux/version.h
make[2]: Nothing to be done for `relocs'.
  Using /usr/projects/linux/ext4 as source for kernel
  CHK     include/generated/utsrelease.h
  CALL    /usr/projects/linux/ext4/scripts/checksyscalls.sh
<stdin>:1220:2: warning: #warning syscall kcmp not implemented [-Wcpp]
<stdin>:1223:2: warning: #warning syscall finit_module not implemented [-Wcpp]
  CHECK   /usr/projects/linux/ext4/fs/ext4/acl.c
/usr/projects/linux/ext4/include/linux/posix_acl.h:137:9: warning: incorrect type in assignment (different address spaces)
/usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    expected struct posix_acl *<noident>
/usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    got struct posix_acl [noderef] <asn:4>*<noident>
/usr/projects/linux/ext4/include/linux/posix_acl.h:137:9: warning: incorrect type in assignment (different address spaces)
/usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    expected struct posix_acl *<noident>
/usr/projects/linux/ext4/include/linux/posix_acl.h:137:9:    got struct posix_acl [noderef] <asn:4>*<noident>
