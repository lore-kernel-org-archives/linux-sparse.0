From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 207959] Don't warn about the universal zero initializer for a
 structure with the 'designated_init' attribute.
Date: Thu, 28 May 2020 22:47:33 +0000
Message-ID: <bug-207959-200559-zVgylh0m00@https.bugzilla.kernel.org/>
References: <bug-207959-200559@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437200AbgE1Wre (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 18:47:34 -0400
In-Reply-To: <bug-207959-200559@https.bugzilla.kernel.org/>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207959

--- Comment #6 from Asher Gordon (AsDaGo@posteo.net) ---
(In reply to Luc Van Oostenryck from comment #3)
> Can't you just add this option in your
> SPARSE_FLAGS or something like that?

Well, actually I'm not using Sparse for my project. I want to use the
'designated_init' attribute since it is supported by GCC. And I want to use the
attribute mainly so that users of my library get the warning, and I can't
control what flags the user uses (and GCC doesn't have a
-Wno-universal-initializer flag anyway).

(In reply to Linus Torvalds from comment #4)
> So yeah, the sparse defaults may be a bit kernel-centric.

That's fine, but perhaps GCC should add something like
-Wno-universal-initializer and use it by default. I'll suggest that in the GCC
bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95379).

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
