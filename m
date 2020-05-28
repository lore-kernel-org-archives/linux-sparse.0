From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 207959] Don't warn about the universal zero initializer for a
 structure with the 'designated_init' attribute.
Date: Thu, 28 May 2020 19:22:14 +0000
Message-ID: <bug-207959-200559-IG36fkwdeW@https.bugzilla.kernel.org/>
References: <bug-207959-200559@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406445AbgE1TWP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 15:22:15 -0400
In-Reply-To: <bug-207959-200559@https.bugzilla.kernel.org/>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207959

Luc Van Oostenryck (luc.vanoostenryck@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luc.vanoostenryck@gmail.com

--- Comment #1 from Luc Van Oostenryck (luc.vanoostenryck@gmail.com) ---
In fact, sparse already support this via the option
'-Wno-universal-initializer'. It's really very recent and thus only in the
mainline tree, not in a release (and it was introduced for another warning but
the result is the same).

My very personal point of view is that the correct syntax should be '{ }'
because it conveys much better the idea of a default initializer. This single
zero in '{ 0 }' is just confusing.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
