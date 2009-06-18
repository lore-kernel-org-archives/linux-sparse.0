From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Turn off '-Wtransparent-union' by default
Date: Thu, 18 Jun 2009 09:52:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906180951570.16802@localhost.localdomain>
References: <alpine.LFD.2.01.0906180940490.16802@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40565 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089AbZFRQwt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 12:52:49 -0400
In-Reply-To: <alpine.LFD.2.01.0906180940490.16802@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org


It's a very annoying warning, and it's about a sparse limitation rather
than a real feature, so don't do it by default.

Sure, our lack of transparent union support will then make us warn about
the magic calling convention hacks (eg you'll see warnings like

	connect.c:240:39: warning: incorrect type in argument 2 (invalid types)
	connect.c:240:39:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
	connect.c:240:39:    got struct sockaddr *ai_addr

but it still doesn't mean that we have to be so noisy about just seeing
those transparent unions.  One annoying warning is not an argument for
doing _another_ annoying warning too (and the calling convention
warnings at least only happen if you actually use them, unlike the
transparent union warning that happens every time we see one, used or
not).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 lib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib.c b/lib.c
index 2b8d21e..42affcd 100644
--- a/lib.c
+++ b/lib.c
@@ -206,7 +206,7 @@ int Wparen_string = 0;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
 int Wshadow = 0;
-int Wtransparent_union = 1;
+int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
