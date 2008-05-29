From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Thu, 29 May 2008 15:47:26 -0700
Message-ID: <1212101246.28403.154.camel@brick>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick>
	 (sfid-20080530_003519_648056_2583259D)  <1212101102.10109.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:64778 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYE2Wr2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 18:47:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3118492wfd.4
        for <linux-sparse@vger.kernel.org>; Thu, 29 May 2008 15:47:27 -0700 (PDT)
In-Reply-To: <1212101102.10109.5.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

On Fri, 2008-05-30 at 00:45 +0200, Johannes Berg wrote:
> On Thu, 2008-05-29 at 15:35 -0700, Harvey Harrison wrote:
> > On Thu, 2008-05-29 at 10:54 +0200, Johannes Berg wrote:
> > > This updates the context tracking, I just explained most of it in the mail
> > > "Re: sparse context warning problem ..."
> > > (message ID <1212050823.16917.37.camel@johannes.berg>)
> > > 
> > 
> > With these applied I get a new error when checking
> > fs/minix/itree_common.c
> 
> What sort? Right now, it seems to go into a dead loop on
> fs/minix/itree_v1.c for me?!
> 

That would be the one....after a long spew ending in:

fs/minix/itree_common.c:44:2: warning: label 'continue' already bound
fs/minix/itree_common.c:44:2: warning: label 'break' already bound
fs/minix/itree_common.c:19:2: warning: label 'continue' already bound
fs/minix/itree_common.c:19:2: warning: label 'break' already bound

Something has gotten a bit confused somewhere.

Harvey

