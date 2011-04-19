From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] Fix 'already_tokenized()' performance problem
Date: Tue, 19 Apr 2011 11:12:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1104191108330.21972@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50083 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab1DSSMv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Apr 2011 14:12:51 -0400
Received: by pvg12 with SMTP id 12so2749533pvg.19
        for <linux-sparse@vger.kernel.org>; Tue, 19 Apr 2011 11:12:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org


This series of two trivial patches makes 'already_tokenized()' go away 
from profiles of a kernel build with C=2, shaving about 3-4% off the time 
for me.

This came up in a discussion on another tech board, and people were 
complaining that I hadn't optimized the pre-processor sufficiently.

(Depending on compiler, usually the profile will show 'strcmp()' taking 
all the time - it depends on whether the strcmp gets inlined or not)

Linus Torvalds (2):
  Add new streams to a hash-list based on their names
  Teach 'already_tokenized()' to use the stream name hash table

 pre-process.c |    8 +++++---
 token.h       |    3 ++-
 tokenize.c    |   25 ++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 5 deletions(-)

-- 
1.7.5.rc1.1.gc3f61.dirty

