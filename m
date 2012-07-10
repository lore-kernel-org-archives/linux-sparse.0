From: Daniel Santos <danielfsantos@att.net>
Subject: Generic Red-Black Trees: preliminary performance results
Date: Tue, 10 Jul 2012 04:58:01 -0500
Message-ID: <4FFBFCA9.2060307@att.net>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm2.access.bullet.mail.sp2.yahoo.com ([98.139.44.129]:46282
	"HELO nm2.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751874Ab2GJJ5t (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Jul 2012 05:57:49 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Rob Landley <rob@landley.net>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>

I've completed some rudimentary test code.  It is designed to compile
both in user & kernel space but only currently compiles in userland.  I
ran this on 9 different versions of gcc, all on x86_64 with CFLAGS="-O2
-g3 -pipe -march=k8".  The below summary data shows the % increase in
time consumed (decrease in performance) using my generic red-black trees
over hand-coded functions for insertion.

gcc ver  % decrease in speed
4.7.1       -5.39%
4.6.2        2.60%
4.5.3       18.07%
4.4.6       20.52%
4.3.6       13.53%
4.2.4       11.84%
4.1.2       16.36%
4.0.4       35.70%
3.4.6       47.28%

I don't understand why the generic code ran faster than hand-coded on
gcc 4.7.1 as I haven't examined the assembly output yet.  However, I'm
pretty certain I understand why it was 2% slower on 4.6.  This has to do
with an optimization flaw.  In the hand-coded insert/find functions, I
used  the "if (a->key > b->key) .. else if (a->key < b->key)" construct,
where as the generic code calculates a diff and compares that against
zero and 4.6.2 is adding an unnecessary cmp instruction:

 3f2:   8b 48 18                mov    0x18(%rax),%ecx
 3f5:   8b 7a 18                mov    0x18(%rdx),%edi
 3f8:   48 29 f9                sub    %rdi,%rcx
 3fb:   48 83 f9 00             cmp    $0x0,%rcx
 3ff:   7f df                   jg     3e0 <grbtest_insert+0xb0>
 401:   0f 84 c9 00 00 00       je     4d0 <grbtest_insert+0x1a0>

The test configuration was for a tree that tracks both leftmost,
rightmost and count and uses unique keys where the insert function
replaces an existing object. These tests weren't ideal.  While I
allocated 4096 objects (32 bytes each) to stick in my tree, I used 0xff
for a key mask, so only 256 object would be in the tree at once and I
didn't notice this until I was most of the way through the tests.  My
intention was to run the test with a data set small enough to fit into
the L3 cache, so as to reduce overhead from memory access and isolate
the actual differences in the algorithm.

When I get this all cleaned up, I'll release another patch set with the
test code added.  (This also automates correctness tests for find,
insert, find_near and insert_near). Also, I'm going to experiment with
branch prediction to see if I can squeeze a little more performance out
of the older compilers.

Daniel
