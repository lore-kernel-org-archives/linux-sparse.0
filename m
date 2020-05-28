From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 207959] Don't warn about the universal zero initializer for a
 structure with the 'designated_init' attribute.
Date: Thu, 28 May 2020 20:52:15 +0000
Message-ID: <bug-207959-200559-GOVNPvIDGp@https.bugzilla.kernel.org/>
References: <bug-207959-200559@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407319AbgE1UwP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 16:52:15 -0400
In-Reply-To: <bug-207959-200559@https.bugzilla.kernel.org/>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207959

--- Comment #2 from Asher Gordon (AsDaGo@posteo.net) ---
(In reply to Luc Van Oostenryck from comment #1)
> In fact, sparse already support this via the option
> '-Wno-universal-initializer'.

Perhaps '-Wno-universal-initializer' should be the default?

> My very personal point of view is that the correct syntax should be '{ }'
> because it conveys much better the idea of a default initializer. This
> single zero in '{ 0 }' is just confusing.

I can see your point, but unfortunately, as Ramsay Jones says here[1] and
Alexander Monakov here[2], this is not standard C. So '{ }' isn't an option if
we want to be portable. Andrew Pinski's suggestion[3] is also an option, but
that seems ugly to me.

[1]  https://marc.info/?l=linux-sparse&m=159069587406366&w=2
[2]  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95379#c4
[3]  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95379#c1

I'm writing a library, Mu[4], which has a structure for which the
'designated_init' attribute is appropriate (see the 'MU_OPT' structure
here[5]). However, I don't want to force my users not to use '{ 0 }', which is
why I think this feature would be useful.

[4]  https://nongnu.org/libmu/
[5]  https://git.savannah.nongnu.org/cgit/libmu.git/tree/src/options.h#n85

Also, a minor note: In the test program I attached, the attribute needs to be
specified after the closing brace to work with Sparse.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
