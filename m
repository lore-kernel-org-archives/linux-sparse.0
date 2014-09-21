From: Alain Kalker <a.c.kalker@gmail.com>
Subject: sparse-llvm: link errors with LLVM 3.5.0
Date: Sun, 21 Sep 2014 18:49:18 +0000 (UTC)
Message-ID: <lvn6je$63j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35278 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbaIUSzI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Sep 2014 14:55:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcps-linux-sparse@m.gmane.org>)
	id 1XVmHo-00051X-Pj
	for linux-sparse@vger.kernel.org; Sun, 21 Sep 2014 20:55:04 +0200
Received: from 524b772b.cm-4-4b.dynamic.ziggo.nl ([82.75.119.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2014 20:55:04 +0200
Received: from a.c.kalker by 524b772b.cm-4-4b.dynamic.ziggo.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2014 20:55:04 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all,

I'm getting link errors building sparse on Arch Linux, which has LLVM 
version 3.5.0.

An example:
/usr/lib/libLLVMSupport.a(Mutex.o): In function 
`llvm::sys::MutexImpl::MutexImpl(bool)':
(.text._ZN4llvm3sys9MutexImplC2Eb+0x37): undefined reference to 
`pthread_mutexattr_init'

From some discussion in [1], we found that this is most likely due to a 
change in LLVM[2] which requires the new "--system-libs" option to llvm-
config to get the list of link flags for correct linking of system 
libraries (including "-lpthread") needed by the LLVM libraries.

Kind regards,

Alain

[1]: https://bugs.archlinux.org/task/42053
[2]: http://reviews.llvm.org/rL197664

