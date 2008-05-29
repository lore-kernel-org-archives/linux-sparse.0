From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Thu, 29 May 2008 15:35:16 -0700
Message-ID: <1212100516.28403.152.camel@brick>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:59902 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbYE2WfT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 18:35:19 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2356537ywe.1
        for <linux-sparse@vger.kernel.org>; Thu, 29 May 2008 15:35:18 -0700 (PDT)
In-Reply-To: <20080529085402.814224000@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

On Thu, 2008-05-29 at 10:54 +0200, Johannes Berg wrote:
> This updates the context tracking, I just explained most of it in the mail
> "Re: sparse context warning problem ..."
> (message ID <1212050823.16917.37.camel@johannes.berg>)
> 

With these applied I get a new error when checking
fs/minix/itree_common.c

I'll try and track it down.

Harvey

