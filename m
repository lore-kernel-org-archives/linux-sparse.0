From: Christopher Li <sparse@chrisli.org>
Subject: [ANNOUNCE] sparse-0.2-cl1 is now available
Date: Sun, 4 Feb 2007 00:53:29 -0800
Message-ID: <20070204085329.GA6520@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([204.127.225.94]:58036 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbXBDJUq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 4 Feb 2007 04:20:46 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>, Andrew Morton <akpm@linux-foundation.org>

Hi,

Thank Andrew for giving me some tips how the -mm series works.

I put together a series of patches I have been working on:

http://userweb.kernel.org/~chrisl/sparse-0.2-cl1/

Hopefully it will show up later at:

http://kernel.org/pub/linux/kernel/people/chrisl/sparse/sparse-0.2-cl1/

The most interesting part is the inline function annotation.
The new checker can find out inlined function usage. The interrupt
checker does not depend on x86 asm instruction any more.


Again, comment and feed back are always welcome.

Have a nice week end.

Chris

origin.patch
    006eff06c7adcfb0d06c6fadf6e9b64f0488b2bf URL: git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
sizeof-incomplete
    Fix double semicolon in struct declare
debug-checker
    Adding debug option for showing the linearized instruction.
no-dead-instruction
    Disable liveness "dead" instruction by default.
anon-symbol
    Fix core dump on anonymous symbol.
instruction-buffer-size
    Fix core dump on huge switch
ptr-allocator
    Make the ptrlist using the sparse allocator.
annotate-inline-2
    Add annotation for inline function call.
show-call-symbol-addr
    Show symbol address in calling.
malloc-checker
    Adding the malloc NULL pointer checker.
interrupt-checker
    Adding the interrupt checker
parse-attr
    Free up some special bits in modifiers.


Total 12 patches
