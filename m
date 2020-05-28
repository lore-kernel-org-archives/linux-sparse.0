From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 207959] New: Don't warn about the universal zero initializer
 for a structure with the 'designated_init' attribute.
Date: Thu, 28 May 2020 16:27:17 +0000
Message-ID: <bug-207959-200559@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404861AbgE1Q1R (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 12:27:17 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207959

            Bug ID: 207959
           Summary: Don't warn about the universal zero initializer for a
                    structure with the 'designated_init' attribute.
           Product: Tools
           Version: unspecified
    Kernel Version: Sparse 0.6.1 (Debian: 0.6.1-2+b1)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: enhancement
          Priority: P1
         Component: Sparse
          Assignee: tools_sparse@kernel-bugs.kernel.org
          Reporter: AsDaGo@posteo.net
        Regression: No

Created attachment 289383
  --> https://bugzilla.kernel.org/attachment.cgi?id=289383&action=edit
A test program illustrating the issue

I reported this bug to GCC here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95379

They don't want to diverge GCC's behavior from Sparse's, but I think this would
be a useful feature, and I think it should be implemented in Sparse as well.
Below is my bug report to GCC.

> When the 'designated_init' attribute is used on a structure type, GCC warns
> when an instance of that structure is initialized with '{ 0 }'. I think GCC
> should make an exception for this, since '{ 0 }' is often used to initialize
> all fields of a structure to 0, and it does not depend on the internal
> structure of the structure type.
> 
> If '{ }' is used to initialize the structure, GCC does not warn. However,
> although '{ }' seems to initialize the structure to zero in GCC, I'm not
> sure if it's as portable as '{ 0 }' (and it's less readable, IMO). I think
> '{ }' is part of the C++ standard; does anyone know if it's part of C too?
> 
> See the attached test program (compile with 'gcc -o test test.c').

I have also included the same program I attached in the GCC bug report.

Also, since this isn't a bug report for the kernel, I've used Sparse's version
number for the "Kernel Version" field.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
