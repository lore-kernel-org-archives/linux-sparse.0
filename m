From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/3] linearize_statement: split up into helper functions
Date: Sat, 27 Aug 2011 14:26:31 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:44822 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1H0V0i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 17:26:38 -0400
Received: by pzk37 with SMTP id 37so6218592pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 14:26:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>


This is a trivial series of three patches to clean up
linearize_statement() a bit by separating out three of the more
complicated cases. 

No actual code changes.

Linus Torvalds (3):
  Make 'linearize_iterator()' helper function
  Make 'linearize_switch()' helper function
  Make 'linearize_return()' helper function

 linearize.c |  259 +++++++++++++++++++++++++++++++----------------------------
 1 files changed, 136 insertions(+), 123 deletions(-)

-- 
1.7.6.409.ge7a85.dirty

