From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 207959] Don't warn about the universal zero initializer for a
 structure with the 'designated_init' attribute.
Date: Fri, 29 May 2020 19:47:09 +0000
Message-ID: <bug-207959-200559-mFXyBDGZzr@https.bugzilla.kernel.org/>
References: <bug-207959-200559@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgE2TrJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 29 May 2020 15:47:09 -0400
In-Reply-To: <bug-207959-200559@https.bugzilla.kernel.org/>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207959

--- Comment #8 from Linus Torvalds (torvalds@linux-foundation.org) ---
I'm  happy to let the kernel not warn about {0} used for a pointer until I find
some egregious horror-case, and then I know that I can add
-Wuniversal-initializer to warn about it.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
