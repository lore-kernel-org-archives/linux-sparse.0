From: Pekka Enberg <penberg@kernel.org>
Subject: [ANNOUNCE] LLVM backend for Sparse
Date: Sun, 28 Aug 2011 09:08:40 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1108280904070.7603@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49025 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1H1GJF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 28 Aug 2011 02:09:05 -0400
Received: by bke11 with SMTP id 11so3437456bke.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 23:09:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>

Hi everyone,

Jeff Garzik and myself have been hacking on LLVM backed for Sparse. The sources
are available on Github:

   git clone git://github.com/penberg/sparse-llvm.git

You can use sparse-llvm with the 'sparsec' shells script provided in the source
tree. It has a GCC compatible command line interface and uses GCC for linking.
For example, you can try to build sparse with sparse-llvm like this:

   make CC=sparsec

Developers who are interested in looking at the LLVM output can use the
'sparse-llvm' command as follows:

   sparse-llvm foo.c | llvm-dis

The backend is already capable of generating code for simple C code on various
platforms. Supported C features include:

   * Function calls

   * Switch statements

   * if-else statements

   * Arithmetic operations

   * Bitwise operations

   * Floating point arithmetic

There's many features that are not supported so if you see an error message
such as this while compiling a C file:

   sparse-llvm: sparse-llvm.c:165: pseudo_type: Assertion `0' failed.

don't panic because it simply means you're attempting to use an unsupported
feature. Help implementing them is more than welcome!

 			Pekka
